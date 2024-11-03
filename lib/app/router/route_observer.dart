import 'package:flutter/material.dart';
import 'package:sandiapp/app/ui/export_screen.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final Map mainRoutes = {
    Login.routeName: 0,
    HomeScreen.routeName: 1,
  };

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    if (mainRoutes.containsKey(screenName)) {
      mainRoutes[screenName];
    } else {
      mainRoutes[Login.routeName];
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      if (mainRoutes.containsKey(previousRoute.settings.name)) {
        mainRoutes[previousRoute.settings.name];
      } else {
        mainRoutes[Login.routeName];
      }
    }
  }
}
