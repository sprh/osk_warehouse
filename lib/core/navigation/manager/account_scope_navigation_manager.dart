import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/main_page/bloc/bloc.dart';
import '../../../features/main_page/presentation/main_page.dart';
import '../../../features/products/product_data/bloc/bloc.dart';
import '../../../features/products/product_data/presentation/product_data.dart';
import '../../../features/products/product_list/bloc/bloc.dart';
import '../../../features/products/product_list/presentation/product_list_page.dart';
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
import '../logic/models/account_scope_routes.dart';
import 'navigation_manager.dart';

abstract class AccountScopeNavigationManager implements NavigationManager {
  // Workers
  void openUserData([String? username]);

  void openWorkersList();

  // Warehouse
  void openWarehouseList();

  void openWarehouseData([String? warehouseId]);

  // Products
  void openProductsList([String? warehouseId]);

  void openProductData([String? productId]);

  // Requests
  void openRequestsList();

  void openRequestInfoPage(String requestId);
}

class AccountScopeNavigationManagerImpl
    extends RouterDelegate<AccountScopeRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin, NavigationManager
    implements AccountScopeNavigationManager {
  AccountScopeRouteState state = AccountScopeRouteState(
    routes: Queue()..add(AccountScopeRouteMain()),
  );

  final GlobalKey<NavigatorState> _navigatorKey;

  AccountScopeNavigationManagerImpl(this._navigatorKey);

  @override
  Widget build(BuildContext context) => Navigator(
        pages: [
          for (final route in state.routes)
            MaterialPage(
              child: Builder(
                builder: (_) {
                  switch (route) {
                    case AccountScopeRouteMain():
                      return BlocProvider(
                        create: (context) => MainPageBloc(
                          this,
                          AccountScope.of(context).currentUserHolder,
                        ),
                        child: const MainPage(),
                      );
                    case AccountScopeRouteUserData():
                      return BlocProvider(
                        create: (context) => UserDataBloc(
                          this,
                          AccountScope.of(context).userRepository,
                          route.username,
                          AccountScope.of(context).currentUserHolder,
                        ),
                        child: const UserDataPage(),
                      );
                    case AccountScopeRouteWorkersList():
                      return BlocProvider(
                        create: (context) => UserListBloc(
                          this,
                          AccountScope.of(context).userListRepository,
                          AccountScope.of(context).currentUserHolder,
                        ),
                        child: const UserListPage(),
                      );
                    case AccountScopeRouteWarehouseData():
                      return BlocProvider(
                        create: (context) => WarehouseDataBloc(
                          AccountScope.of(context).warehouseRepository,
                          this,
                          AccountScope.of(context).currentUserHolder,
                          route.warehouseId,
                        ),
                        child: const WarehouseDataPage(),
                      );
                    case AccountScopeRouteWarehouseList():
                      return BlocProvider(
                        create: (context) => WarehouseListBloc(
                          this,
                          AccountScope.of(context).warehouseRepository,
                          AccountScope.of(context).currentUserHolder,
                        ),
                        child: const WarehouseListPage(),
                      );
                    case AccountScopeRouteProductsList():
                      return BlocProvider(
                        create: (context) => ProductListBloc(
                          this,
                          AccountScope.of(context).productListRepository,
                          route.warehouseId,
                        ),
                        child: const ProductListPage(),
                      );
                    case AccountScopeRouteRequestsList():
                      return BlocProvider(
                        create: (context) => RequestsListBloc(
                          this,
                        ),
                        child: const RequestsListPage(),
                      );
                    case AccountScopeRouteRequestInfoPage():
                      return const RequestInfoPage();
                    case AccountScopeRouteProductData():
                      return BlocProvider(
                        create: (context) => ProductDataBloc(
                          this,
                          AccountScope.of(context).productRepository,
                          route.productId,
                        ),
                        child: const ProductDataPage(),
                      );
                  }
                },
              ),
            ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          pop();

          return true;
        },
      );

  @override
  void pop() {
    if (canPop) {
      state.routes.removeLast();
      notifyListeners();
    }
  }

  @override
  bool get canPop => state.routes.length > 1;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(AccountScopeRouteState configuration) {
    state = configuration;
    return Future.value();
  }

  @override
  void openUserData([String? username]) {
    state.routes.add(
      AccountScopeRouteUserData(username),
    );
    notifyListeners();
  }

  @override
  void openWorkersList() {
    state.routes.add(
      AccountScopeRouteWorkersList(),
    );
    notifyListeners();
  }

  @override
  void openWarehouseData([String? warehouseId]) {
    state.routes.add(
      AccountScopeRouteWarehouseData(warehouseId),
    );
    notifyListeners();
  }

  @override
  void openWarehouseList() {
    state.routes.add(
      AccountScopeRouteWarehouseList(),
    );
    notifyListeners();
  }

  @override
  void openProductsList([String? warehouseId]) {
    state.routes.add(
      AccountScopeRouteProductsList(warehouseId),
    );
    notifyListeners();
  }

  @override
  void openRequestsList() {
    state.routes.add(
      AccountScopeRouteRequestsList(),
    );
    notifyListeners();
  }

  @override
  void openRequestInfoPage(String requestId) {
    state.routes.add(
      AccountScopeRouteRequestInfoPage(requestId: requestId),
    );
    notifyListeners();
  }

  @override
  void openProductData([String? productId]) {
    state.routes.add(
      AccountScopeRouteProductData(productId),
    );
    notifyListeners();
  }
}
