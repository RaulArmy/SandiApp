import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Btconection extends StatefulWidget {
  // const Homepage({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Btconection> {
  // Donne l'etat du bluethoor commence par  unknown sinon BluetoothState.STATE_ON
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Get the instance of the Bluetooth
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  late BluetoothConnection connection;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection.isConnected;
  late int _deviceState;
  List<BluetoothDevice> _devicesList = [];
  bool isDisconnecting = false;
  late List<BluetoothDevice> _device = [];
  String? nomappareil;
  bool _connected = false;
  @override
  void initState() {
    super.initState();

    // Get current state

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
      enableBluetooth();
    });

    _deviceState = 0; // neutral

    // If the Bluetooth of the device is not enabled,
    // then request permission to turn on Bluetooth
    // as the app starts up

    // Listen for further state changes

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        // For retrieving the paired devices list
        getPairedDevices();
      });
    });
  }

// Demande autorisation mise en route bluetooth
  Future<bool> enableBluetooth() async {
    // Retrieving the current Bluetooth state

    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    //Demande activation du bluetooth si off
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();

      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
      afficheperiphe();
    });
  }

  SimpleDialog afficheperiphe() {
    //  getPairedDevices();

    return SimpleDialog(
        //  title: Text('Choose one'),
        children: _devicesList.map((entry) {
      var name11 = entry.name;
      var w = ListTile(
        title: Text(name11!),
        leading: const Icon(Icons.hourglass_empty),
        trailing: InkWell(
          child: Card(
            color: Colors.black,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 5,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Connexion',
                    style: TextStyle(color: Colors.grey[400]),
                  )),
            ),
          ),
        ),
        onTap: () {
          return connexionblue(entry);
        },
      );

      return w;
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Périphérique Bluetooth'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.greenAccent.shade400,
                Colors.blue,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                afficheperiphe(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => getPairedDevices(),
          tooltip: 'Update',
          child: const Icon(Icons.update),
        ));
  }

  Future<void> _sendOnMessageToBluetooth() async {
    connection.output.add(ascii.encode('Hello!'));
    await connection.output.allSent;
    print('ok send message');
  }

  void connexionblue(BluetoothDevice entry) async {
    if (entry.isConnected) {
      print('connect');
      _sendOnMessageToBluetooth();
    } else {
      BluetoothConnection.toAddress(entry.address).then((_connection) {
        print('Connected to the device');
        connection = _connection;
      }).catchError((error) {
        print('Cannot connect, exception occurred');
        print(error);
      });
    }
  }
}
