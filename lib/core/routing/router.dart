import 'package:flutter/material.dart';
import 'package:todoapp/core/routing/route_paths.dart';

import '../../features/navigation/presentation/screens/splash_screen.dart';

import '../../features/navigation/presentation/screens/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RoutePaths.splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
