import 'package:flutter/material.dart';
import 'package:sandiapp/app/ui/export_screen.dart';
import 'package:sandiapp/app/ui/view/data_anality_screem.dart';
import 'package:sandiapp/app/ui/view/dosis_screem.dart';
import 'package:sandiapp/app/ui/view/new_user_screem.dart';

import '../ui/view/conexion/home.dart';

class AppRouting {
  static PageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Login.routeName:
        return _fadeRoute(Login(), settings);
      case HomeScreen.routeName:
        return _fadeRoute(HomeScreen(), settings);
      case ListDevice.routeName:
        return _fadeRoute(ListDevice(), settings);
      case RegistrarScreen.routeName:
        return _fadeRoute(RegistrarScreen(), settings);
      case DataAnalityScreem.routeName:
        return _fadeRoute(DataAnalityScreem(), settings);
      case DosisScreem.routeName:
        return _fadeRoute(DosisScreem(), settings);
      default:
        return _fadeRoute(Login(), settings);
    }
  }

  static PageRoute _fadeRoute(Widget view, RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => view,
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, animation, __, ___) => FadeTransition(
        opacity: animation,
        child: view,
      ),
    );
  }
}
