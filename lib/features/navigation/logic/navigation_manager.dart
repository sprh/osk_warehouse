import 'package:flutter/material.dart';

import '../models/routes.dart';

abstract class NavigationManager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  void openWelcome();

  void openLogin();

  void openMain();
}

class NavigationManagerImpl extends NavigationManager {
  void openWelcome() =>
      NavigationManager.navigatorKey.currentState?.pushReplacementNamed(
        Routes.welcome.name,
      );

  void openLogin() =>
      NavigationManager.navigatorKey.currentState?.pushReplacementNamed(
        Routes.login.name,
      );

  @override
  void openMain() =>
      NavigationManager.navigatorKey.currentState?.pushReplacementNamed(
        Routes.main.name,
      );
}
