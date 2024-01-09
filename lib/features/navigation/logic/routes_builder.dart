import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../initial_page/presentation/initial_page.dart';
import '../../login/presentation/login_page.dart';
import '../../main_page/presentation/main_page.dart';
import '../../welcome/presentation/welcome_page.dart';
import '../models/routes.dart';

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
      case Routes.login:
        screen = const LoginPage();
        break;
      case Routes.main:
        screen = MainPage();
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
