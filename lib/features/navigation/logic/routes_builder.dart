import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../scopes/app_scope.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/presentation/login_page.dart';
import '../../main_page/bloc/main_page_bloc.dart';
import '../../main_page/presentation/main_page.dart';
import '../../products/products_list/bloc/products_list_bloc.dart';
import '../../products/products_list/presentation/products_list_page.dart';
import '../../requests/request_info/presentation/request_info_page.dart';
import '../../requests/requests_list/bloc/requests_list_bloc.dart';
import '../../requests/requests_list/presentation/requests_list_page.dart';
import '../../warehouse/new_warehouse/new_warehouse.dart';
import '../../warehouse/warehouse_list/bloc/warehouse_list_bloc.dart';
import '../../warehouse/warehouse_list/presentation/warehouse_list_page.dart';
import '../../welcome/bloc/welcome_page_bloc.dart';
import '../../welcome/presentation/welcome_page.dart';
import '../../worker/new_worker/bloc/new_worker_bloc.dart';
import '../../worker/new_worker/presentation/new_worket_page.dart';
import '../../worker/workers_list/bloc/workers_list_bloc.dart';
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
        screen = BlocProvider(
          create: (context) => WelcomePageBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const WelcomePage(),
        );
      case Routes.login:
        screen = BlocProvider(
          create: (context) => LoginBloc(
            AppScope.of(context).navigationManager,
            AppScope.of(context).authManager,
          ),
          child: const LoginPage(),
        );
      case Routes.main:
        screen = BlocProvider(
          create: (context) => MainPageBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const MainPage(),
        );
      case Routes.newWorker:
        screen = BlocProvider(
          create: (context) => NewWorkerBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const NewWorkerPage(),
        );
      case Routes.newWarehouse:
        screen = const NewWarehousePage();
      case Routes.workersList:
        screen = BlocProvider(
          create: (context) => WorkersListBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const WorkersListPage(),
        );
      case Routes.warehouseList:
        screen = BlocProvider(
          create: (context) => WarehouseListBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const WarehouseListPage(),
        );
      case Routes.producsList:
        final warehouseId = settings.arguments as String?;

        screen = BlocProvider(
          create: (context) => ProductsListBloc(
            AppScope.of(context).navigationManager,
            warehouseId,
          ),
          child: const ProductsListPage(),
        );
      case Routes.requestsList:
        screen = BlocProvider(
          create: (context) => RequestsListBloc(
            AppScope.of(context).navigationManager,
          ),
          child: const RequestsListPage(),
        );
      case Routes.requestInfo:
        screen = const RequestInfoPage();
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
