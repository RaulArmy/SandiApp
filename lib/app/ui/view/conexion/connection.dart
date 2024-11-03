import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'device.dart';

class SelectBondedDevicePage extends StatefulWidget {
  /// If true, on page start there is performed discovery upon the bonded devices.
  /// Then, if they are not avaliable, they would be disabled from the selection.
  final bool checkAvailability;
  final Function onCahtPage;

  SelectBondedDevicePage(
      {this.checkAvailability = true, required this.onCahtPage});

  @override
  _SelectBondedDevicePage createState() => _SelectBondedDevicePage();
}

enum _DeviceAvailability {
  //no,
  maybe,
  yes,
}

class _DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability, [this.rssi])
      : super(address: device.address);
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> blutooes = [];

  // Availability
  late StreamSubscription<BluetoothDiscoveryResult>
      _discoveryStreamSubscription;
  late bool _isDiscovering;

  // _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        blutooes = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  /*void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }*/

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = blutooes.iterator;
        while (i.moveNext()) {
          var device = i.current;
          if (device.device == r.device) {
            device.availability = _DeviceAvailability.yes;
            device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = blutooes
        .map(
          (device) => BluetoothDeviceListEntry(
            device: device.device,
            onTap: () {
              conectar(device.device);
              log('nombre : ${device.device.name}');
              log('identidad: ${device.address}');
            },
          ),
        )
        .toList();

    return Container(
      color: Colors.green,
      child: ListView(
        children: list,
      ),
    );
  }

  conectar(BluetoothDevice device) {
    setState(() {
      widget.onCahtPage(device);
    });
  }
}
