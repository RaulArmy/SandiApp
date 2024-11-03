import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:sandiapp/app/ui/export_screen.dart';
import 'package:sandiapp/app/ui/view/conexion/home.dart';

import '../router/route_observer.dart';
import '../router/router.dart';
import '../ui/view/home_screem.dart';

class App extends StatelessWidget {
  App({
    Key? key,
  }) : super(key: key);

  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [AppRouteObserver()],
      onGenerateRoute: AppRouting.generateRoute,
      title: 'SandiApp',
      initialRoute: HomeScreen.routeName,
      // home: FutureBuilder(
      //   future: FlutterBluetoothSerial.instance.requestEnable(),
      //   builder: (context, future) {
      //     if (future.connectionState == ConnectionState.waiting) {
      //       return const Scaffold(
      //         body: SizedBox(
      //           height: double.infinity,
      //           child: Center(
      //             child: Icon(
      //               Icons.bluetooth_disabled,
      //               size: 200.0,
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //       );
      //     } else {
      //       return ListDevice();
      //     }
      //   },
      // ),
    );
  }
}
