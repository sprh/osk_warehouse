import 'package:flutter/material.dart';

import '../../../components/actions/actions_flex.dart';
import '../../../components/modal/modal_dialog.dart';
import '../../../theme/utils/theme_from_context.dart';
import 'models/routes.dart';

abstract class NavigationManager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  factory NavigationManager() => const _NavigationManagerImpl();

  void openWelcome();

  void openLogin();

  void openMain();

  // Workers
  void openNewWorker();

  void openWorkersList();

  // Warehouse
  void openWarehouseList();

  void openNewWarehouse();

  // Products
  void openProductsList([String? warehouseId]);

  // Requests
  void openRequestsList();

  void openRequestInfoPage(String requestId);

  void pop();

  void showModalDialog({
    required String title,
    String? subtitle,
    OskActionsFlex? actions,
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
  void pop() => NavigationManager.navigatorKey.currentState?.pop();

  @override
  void showModalDialog({
    required String title,
    String? subtitle,
    OskActionsFlex? actions,
    bool dismissible = false,
  }) {
    final context = NavigationManager.navigatorKey.currentState?.context;
    if (context != null) {
      showDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        barrierColor: context.modalDialogTheme.barrierColor,
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

  @override
  void openNewWarehouse() =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.newWarehouse.name,
      );

  @override
  void openWarehouseList() =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.warehouseList.name,
      );

  @override
  void openProductsList([String? warehouseId]) =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.producsList.name,
        arguments: warehouseId,
      );

  @override
  void openRequestsList() =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.requestsList.name,
      );

  @override
  void openRequestInfoPage(String requestId) =>
      NavigationManager.navigatorKey.currentState?.pushNamed(
        Routes.requestInfo.name,
        arguments: requestId,
      );
}
