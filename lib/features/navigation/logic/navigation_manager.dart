import 'package:flutter/material.dart';
import 'package:osk_warehouse/features/navigation/models/routes.dart';

abstract class NavigationManager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  void openWelcome();

  void openLogin();
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
}
