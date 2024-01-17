import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../login/presentation/login_page.dart';
import '../../main_page/presentation/main_page.dart';
import '../../warehouse/new_warehouse/new_warehouse.dart';
import '../../warehouse/warehouse_list/presentation/warehouse_list_page.dart';
import '../../welcome/presentation/welcome_page.dart';
import '../../worker/new_worker/presentation/new_worket_page.dart';
import '../../worker/workers_list/presentation/workers_list_page.dart';
import 'models/routes.dart';

class RoutesBuilder {
  RoutesBuilder._();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final route = Routes.values.firstWhereOrNull(
          (route) => route.name == settings.name,
        ) ??
        Routes.welcome;

    late final Widget screen;

    switch (route) {
      case Routes.welcome:
        screen = const WelcomePage();
      case Routes.login:
        screen = const LoginPage();
      case Routes.main:
        screen = const MainPage();
      case Routes.newWorker:
        screen = const NewWorkerPage();
      case Routes.newWarehouse:
        screen = const NewWarehousePage();
      case Routes.workersList:
        screen = const WorkersListPage();
      case Routes.warehouseList:
        screen = const WarehouseListPage();
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
