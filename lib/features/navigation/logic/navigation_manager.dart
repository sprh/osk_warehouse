import 'package:flutter/material.dart';
import 'package:osk_warehouse/features/navigation/models/routes.dart';

class NavigationManager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  void openWelcome() => navigatorKey.currentState?.pushNamed(
        Routes.welcome.name,
      );
}
