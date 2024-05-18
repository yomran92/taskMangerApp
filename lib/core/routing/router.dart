import 'package:flutter/material.dart';
import 'package:todoapp/core/routing/route_paths.dart';

import '../../features/account/presentation/screens/login_screen.dart';
import '../../features/navigation/presentation/screens/splash_screen.dart';
import '../../features/task/presentation/screens/tasks_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());

      case RoutePaths.splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RoutePaths.TaskScreen:
        return MaterialPageRoute(builder: (_) => TaskScreen());

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
