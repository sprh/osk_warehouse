import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:osk_warehouse/navigation/routes.dart';

class RoutesBuilder {
  RoutesBuilder._();

  static Route generateRoutes(RouteSettings settings) {
    final route = Routes.values.firstWhereOrNull(
          (route) => route.name == settings.name,
        ) ??
        Routes.initial;

    late final Widget screen;

    switch (route) {
      case Routes.initial:
        // TODO: Handle this case.
        break;
      case Routes.welcome:
        // TODO: Handle this case.
        break;
      case Routes.login:
        // TODO: Handle this case.
        break;
    }
  }
}
