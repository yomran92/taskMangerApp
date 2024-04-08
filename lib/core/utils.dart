import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void pushNavigateTo(context, bool withNavBar, String route,
      {arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(route, arguments: arguments);
    });
  }

  Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }

  static Future<T?> pushNewScreenWithRouteSettings<T>(
    final BuildContext context, {
    required final Widget screen,
    required final RouteSettings settings,
    bool? withNavBar,
    final PageRoute<T>? customPageRoute,
  }) {
    withNavBar ??= true;

    return Navigator.of(context, rootNavigator: !withNavBar)
        .push<T>(customPageRoute as Route<T>);
  }

  static void pushReplacementNavigateTo(context, String route, {arguments}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
    });
  }

  static Future<T?> pushDynamicScreen<T>(
    BuildContext context, {
    required dynamic screen,
    bool? withNavBar,
  }) {
    if (withNavBar == null) {
      withNavBar = true;
    }
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(screen);
  }

  static void popNavigate(context, {int popsCount = 1, bool value = false}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      for (int i = 0; i < popsCount; i++) {
        Navigator.of(context).maybePop(value);
      }
    });
  }

  static void popNavigateToFirst(context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  static void clearAndPush(context, newRouteName) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(newRouteName, (route) => false);
    });
  }
}
