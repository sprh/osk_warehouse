import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/main_page/bloc/main_page_bloc.dart';
import '../../../features/main_page/presentation/main_page.dart';
import '../../../features/products/products_list/bloc/products_list_bloc.dart';
import '../../../features/products/products_list/presentation/products_list_page.dart';
import '../../../features/requests/request_info/presentation/request_info_page.dart';
import '../../../features/requests/requests_list/bloc/requests_list_bloc.dart';
import '../../../features/requests/requests_list/presentation/requests_list_page.dart';
import '../../../features/user/user_data/bloc/bloc.dart';
import '../../../features/user/user_data/presentation/user_data_page.dart';
import '../../../features/user/users_list/bloc/bloc.dart';
import '../../../features/user/users_list/presentation/workers_list_page.dart';
import '../../../features/warehouse/warehouse_data/bloc/bloc.dart';
import '../../../features/warehouse/warehouse_data/presentation/warehouse_data.dart';
import '../../../features/warehouse/warehouse_list/bloc/warehouse_list_bloc.dart';
import '../../../features/warehouse/warehouse_list/presentation/warehouse_list_page.dart';
import '../../scopes/account_scope.dart';
import 'models/account_scope_routes.dart';

final class AccountScopeRoutesBuilder {
  AccountScopeRoutesBuilder._();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final route = AccountScopeRoutes.values.firstWhereOrNull(
          (route) => route.name == settings.name,
        ) ??
        AccountScopeRoutes.main;

    late final Widget screen;

    switch (route) {
      case AccountScopeRoutes.main:
        screen = BlocProvider(
          create: (context) => MainPageBloc(
            AccountScope.of(context).navigationManager,
          ),
          child: const MainPage(),
        );
      case AccountScopeRoutes.userData:
        final username = settings.arguments as String?;

        screen = BlocProvider(
          create: (context) => UserDataBloc(
            AccountScope.of(context).navigationManager,
            AccountScope.of(context).userRepository,
            username,
          ),
          child: const UserDataPage(),
        );
      case AccountScopeRoutes.warehouseData:
        final warehouseId = settings.arguments as String?;

        screen = BlocProvider(
          create: (context) => WarehouseDataBloc(
            AccountScope.of(context).warehouseRepository,
            AccountScope.of(context).navigationManager,
            warehouseId,
          ),
          child: const WarehouseDataPage(),
        );
      case AccountScopeRoutes.workersList:
        screen = BlocProvider(
          create: (context) => UserListBloc(
            AccountScope.of(context).navigationManager,
            AccountScope.of(context).userListRepository,
          ),
          child: const UserListPage(),
        );
      case AccountScopeRoutes.warehouseList:
        screen = BlocProvider(
          create: (context) => WarehouseListBloc(
            AccountScope.of(context).navigationManager,
            AccountScope.of(context).warehouseRepository,
          ),
          child: const WarehouseListPage(),
        );
      case AccountScopeRoutes.producsList:
        final warehouseId = settings.arguments as String?;

        screen = BlocProvider(
          create: (context) => ProductsListBloc(
            AccountScope.of(context).navigationManager,
            warehouseId,
          ),
          child: const ProductsListPage(),
        );
      case AccountScopeRoutes.requestsList:
        screen = BlocProvider(
          create: (context) => RequestsListBloc(
            AccountScope.of(context).navigationManager,
          ),
          child: const RequestsListPage(),
        );
      case AccountScopeRoutes.requestInfo:
        screen = const RequestInfoPage();
    }

    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
