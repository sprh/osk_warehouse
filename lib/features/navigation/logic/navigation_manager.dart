import 'package:flutter/material.dart';

import 'models/routes.dart';

abstract class NavigationManager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  factory NavigationManager() => _NavigationManagerImpl();

  void openWelcome();

  void openLogin();

  void openMain();

  void openNewWorker();

  void openWorkersList();

  void pop();
}

class _NavigationManagerImpl implements NavigationManager {
  const _NavigationManagerImpl();

  @override
  void openLogin() =>
      NavigationManager.navigatorKey.currentState?.pushReplacementNamed(
        Routes.login.name,
      );

  @override
  void openMain() =>
      NavigationManager.navigatorKey.currentState?.pushReplacementNamed(
        Routes.main.name,
      );

  @override
  void openWelcome() =>
      NavigationManager.navigatorKey.currentState?.pushReplacementNamed(
        Routes.welcome.name,
      );

  @override
  void openNewWorker() =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.newWorker.name,
      );

  @override
  void openWorkersList() =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.newWorker.name,
      );

  @override
  void pop() => NavigationManager.navigatorKey.currentState?.maybePop();
}
