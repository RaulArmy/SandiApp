import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sandiapp/app/ui/view/conexion/connection.dart';

import 'led.dart';

class ListDevice extends StatefulWidget {
  static const routeName = "/ListDeviceScrem";
  @override
  State<ListDevice> createState() => _ListDeviceState();
}

class _ListDeviceState extends State<ListDevice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Lista de bluetooth'),
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ChatPage(server: device);
              },
            ),
          );
        },
      ),
    ));
  }
}
