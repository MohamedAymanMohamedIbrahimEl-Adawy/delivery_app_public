import 'package:flutter/material.dart';

import '../../ui/screens/auth/login/screen/login_screen.dart';
import '../../ui/screens/orders/orders_screen.dart';
import '../../ui/screens/notifications/notifications_screen.dart';
import '../../ui/screens/onboard/screen/onboard_screen.dart';
import '../../ui/screens/splash/screen/splash_screen.dart';

class AppRoutes {
  final Map<String, Widget Function(BuildContext)> _routes = {
    OrdersScreen.routeName: (_) => OrdersScreen(),
    OnboardScreen.routeName: (_) => const OnboardScreen(),
    NotificationsScreen.routeName: (_) => const NotificationsScreen(),
    SplashScreen.routeName: (_) => const SplashScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
  };

  final String _initialRoute = '/';

  Map<String, Widget Function(BuildContext)> get getRoutes {
    return _routes;
  }

  String get getInitialRoute {
    return _initialRoute;
  }
}
