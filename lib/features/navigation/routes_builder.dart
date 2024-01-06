import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:osk_warehouse/features/initial_page/presentation/initial_page.dart';
import 'package:osk_warehouse/features/navigation/models/routes.dart';
import 'package:osk_warehouse/features/welcome/presentation/welcome_page.dart';

class RoutesBuilder {
  RoutesBuilder._();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final route = Routes.values.firstWhereOrNull(
          (route) => route.name == settings.name,
        ) ??
        Routes.initial;

    late final Widget screen;

    switch (route) {
      case Routes.initial:
        screen = const InitialPage();
        break;
      case Routes.welcome:
        screen = const WelcomePage();
        break;
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
