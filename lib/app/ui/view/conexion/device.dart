import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatefulWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({required this.device, required this.onTap});

  @override
  State<BluetoothDeviceListEntry> createState() =>
      _BluetoothDeviceListEntryState();
}

class _BluetoothDeviceListEntryState extends State<BluetoothDeviceListEntry> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.devices),
      title: Text(widget.device.name ?? "Unknown device"),
      subtitle: Text(widget.device.address.toString()),
      trailing: TextButton(
        child: const Text('Conectar'),
        onPressed: _conectar,
      ),
    );
  }

//metodo para conectar
  _conectar() {
    setState(() {
      widget.onTap();
    });
  }
}
