import 'package:flutter/material.dart';

import '../../../components/modal/modal_dialog.dart';
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

  void showModalDialog({
    required String title,
    String? subtitle,
    Widget? actions,
    bool dismissible = false,
  });
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
        Routes.workersList.name,
      );

  @override
  void pop() => NavigationManager.navigatorKey.currentState?.maybePop();

  @override
  void showModalDialog({
    required String title,
    String? subtitle,
    Widget? actions,
    bool dismissible = false,
  }) {
    final context = NavigationManager.navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: dismissible,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) => PopScope(
          canPop: dismissible,
          child: ModalDialog(
            title: title,
            subtitle: subtitle,
            actions: actions,
          ),
        ),
      );
    }
  }
}
