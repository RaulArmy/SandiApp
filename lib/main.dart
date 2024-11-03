import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/context/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

checkPerm() async {
  var status = await Permission.bluetooth.status;
  if (status.isDenied) {
    await Permission.bluetooth.request();
  }
  if (await Permission.bluetooth.status.isPermanentlyDenied) {
    openAppSettings();
  }
}
