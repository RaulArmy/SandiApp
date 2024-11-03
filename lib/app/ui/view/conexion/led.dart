import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPage createState() => _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static const clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = [];
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    log(': ${widget.server}');
    BluetoothConnection.toAddress(widget.server.address).then((connectionItem) {
      log('Connected to the device : ${widget.server.address}');
      connection = connectionItem;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection?.input?.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          log('Disconnecting locally!');
        } else {
          log('Disconnected remotely!');
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      log('Cannot connect, exception occured');
      log(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection?.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((message) {
      return Row(
        // ignore: sort_child_properties_last
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color: message.whom == clientID
                    ? Colors.blueAccent
                    : Colors.deepPurple,
                borderRadius: BorderRadius.circular(7.0)),
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_nuevo(message).text.trim()),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
        mainAxisAlignment: message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: (isConnecting
            ? Text('Conectado con ${widget.server.name!}...')
            : isConnected
                ? Text('Mediciones de ${widget.server.name!}')
                : Text(' ${widget.server.name!}')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Datos obtenidos del monitoreo',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(5),
              width: double.infinity,
            ),
            Flexible(
              child: ListView(
                //scrollDirection: Axis.vertical,
                padding:
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 30),
                controller: listScrollController,
                children: list,
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       height: 150,
            //       child: _customData(),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0),
                      controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: isConnecting
                            ? 'Esperando conexión...'
                            : isConnected
                                ? 'Conetado...'
                                : 'Chat desconectado',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.save_rounded,
                        color: Colors.greenAccent,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'product');
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _customData() {
    return Card(
      color: Colors.green,
      child: SizedBox(
        height: 100,
        width: 300,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [Text('Datos +++>')],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _Message _nuevo(_Message _message) {
    var datos = _message.text.trim();
    List<String> datos2 = datos.split("-");

    if (datos2.length > 1) {
      //  n.selectedMedi.ph = double.parse(datos2[0]);
      //  n.selectedMedi.temperatura = double.parse(datos2[1]);
    }
    //print(n.selectedMedi.ph);
    return _message;
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection?.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection?.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(const Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
