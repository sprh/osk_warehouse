import 'dart:collection';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/actions/actions_flex.dart';
import '../../../common/components/button/osk_button.dart';
import '../../../features/applications/application_data/bloc/bloc.dart';
import '../../../features/applications/application_data/presentation/application_data_page.dart';
import '../../../features/applications/applications_list/bloc/bloc.dart';
import '../../../features/applications/applications_list/presentation/applications_list_page.dart';
import '../../../features/applications/create_application/bloc/bloc.dart';
import '../../../features/applications/create_application/presentation/create_appication_page.dart';
import '../../../features/applications/models/application/application.dart';
import '../../../features/barcode/barcode_scanner.dart';
import '../../../features/main_page/bloc/bloc.dart';
import '../../../features/main_page/presentation/main_page.dart';
import '../../../features/products/product_data/bloc/bloc.dart';
import '../../../features/products/product_data/presentation/product_data.dart';
import '../../../features/products/product_list/bloc/bloc.dart';
import '../../../features/products/product_list/presentation/product_list_page.dart';
import '../../../features/products/select_products/bloc/bloc.dart';
import '../../../features/products/select_products/presentation/select_products_page.dart';
import '../../../features/reports/bloc/bloc.dart';
import '../../../features/reports/presentation/reports_list_page.dart';
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
  void openUserData({String? username, bool canEdit = true});

  void openWorkersList();

  // Warehouse
  void openWarehouseList();

  void openWarehouseData([String? warehouseId]);

  // Products
  void openProductsList([String? warehouseId]);

  void openProductData({String? productId, bool canEdit = true});

  // Requests
  void openApplicationsList();

  void openCreateApplicationPage();

  void onSelectProducts(
    OnSelectProducts onSelectProductsCallback,
    String? warehouseId, [
    Set<String>? selectedProducts,
  ]);

  void openApplicationData(String id);

  void openReports();

  Future<void> openCalenarPicker(
    CalendarDatePicker2Config config,
    void Function(List<DateTime>) onPeriodChanged,
    List<DateTime> initialPeriod,
  );

  void openEditApplication(Application application);
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
                          AccountScope.of(context).authManager,
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
                          canEdit: route.canEdit,
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
                          AccountScope.of(context).currentUserHolder,
                        ),
                        child: const ProductListPage(),
                      );
                    case AccountScopeRouteApplicationsList():
                      return BlocProvider(
                        create: (context) => ApplicationsListBloc(
                          AccountScope.of(context).applicationsListRepository,
                          this,
                        ),
                        child: const ApplicationsListPage(),
                      );
                    case AccountScopeRouteCreateApplicationPage():
                      return BlocProvider(
                        create: (context) => CreateApplicationBloc(
                          AccountScope.of(context).warehouseRepository,
                          this,
                          AccountScope.of(context).createApplicationRepository,
                          AccountScope.of(context).applicationsListRepository,
                          BarcodeScanner(this),
                          AccountScope.of(context).productListRepository,
                        ),
                        child: const CreateApplicationPage(),
                      );
                    case AccountScopeRouteEditApplicationPage():
                      return BlocProvider(
                        create: (context) => CreateApplicationBloc(
                          AccountScope.of(context).warehouseRepository,
                          this,
                          AccountScope.of(context).createApplicationRepository,
                          AccountScope.of(context).applicationsListRepository,
                          BarcodeScanner(this),
                          AccountScope.of(context).productListRepository,
                          route.application,
                        ),
                        child: const CreateApplicationPage(),
                      );
                    case AccountScopeRouteProductData():
                      return BlocProvider(
                        create: (context) => ProductDataBloc(
                          this,
                          AccountScope.of(context).productRepository,
                          AccountScope.of(context).productListRepository,
                          AccountScope.of(context).currentUserHolder,
                          BarcodeScanner(this),
                          route.productId,
                          canEdit: route.canEdit,
                        ),
                        child: const ProductDataPage(),
                      );
                    case AccountScopeRouteSelectProducts():
                      return BlocProvider(
                        create: (context) => SelectProductsBloc(
                          AccountScope.of(context).productListRepository,
                          route.onSelect,
                          route.warehouseId,
                          this,
                          route.selectedProducts ?? {},
                        ),
                        child: const SelectProductsPage(),
                      );
                    case AccountScopeRouteApplicationData():
                      return BlocProvider(
                        create: (context) => ApplicationDataBloc(
                          this,
                          AccountScope.of(context).applicationDataRepository,
                          route.applicationId,
                          AccountScope.of(context).applicationsListRepository,
                        ),
                        child: const ApplicationDataPage(),
                      );
                    case AccountScopeRouteReports():
                      return BlocProvider(
                        create: (context) => ReportsBloc(
                          this,
                          AccountScope.of(context).reportsRepository,
                        ),
                        child: const ReportsListPage(),
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
        key: navigatorKey,
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
  void openUserData({String? username, bool canEdit = true}) {
    state.routes.add(
      AccountScopeRouteUserData(username: username, canEdit: canEdit),
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
  void openApplicationsList() {
    state.routes.add(
      AccountScopeRouteApplicationsList(),
    );
    notifyListeners();
  }

  @override
  void openCreateApplicationPage() {
    state.routes.add(
      const AccountScopeRouteCreateApplicationPage(),
    );
    notifyListeners();
  }

  @override
  void openEditApplication(Application application) {
    state.routes.add(
      AccountScopeRouteEditApplicationPage(application),
    );
    notifyListeners();
  }

  @override
  void openProductData({String? productId, bool canEdit = true}) {
    state.routes.add(
      AccountScopeRouteProductData(productId: productId, canEdit: canEdit),
    );
    notifyListeners();
  }

  @override
  void onSelectProducts(
    OnSelectProducts onSelectProductsCallback,
    String? warehouseId, [
    Set<String>? selectedProducts,
  ]) {
    state.routes.add(
      AccountScopeRouteSelectProducts(
        onSelectProductsCallback,
        warehouseId,
        selectedProducts,
      ),
    );
    notifyListeners();
  }

  @override
  void openApplicationData(String id) {
    state.routes.add(
      AccountScopeRouteApplicationData(id),
    );
    notifyListeners();
  }

  @override
  void openReports() {
    state.routes.add(
      const AccountScopeRouteReports(),
    );

    notifyListeners();
  }

  @override
  Future<void> openCalenarPicker(
    CalendarDatePicker2Config config,
    void Function(List<DateTime>) onPeriodChanged,
    List<DateTime> initialPeriod,
  ) async {
    var dates = <DateTime>[];
    await showModal(
      (context) {
        var doneButtonEnabled = false;

        return StatefulBuilder(
          builder: (
            context,
            setState,
          ) =>
              SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                CalendarDatePicker2(
                  config: config,
                  value: dates,
                  onValueChanged: (value) {
                    dates = value.whereNotNull().toList();
                    doneButtonEnabled =
                        dates.isNotEmpty && dates != initialPeriod;
                    setState(() {});
                  },
                ),
                OskActionsFlex(
                  widgets: [
                    OskButton.minor(
                      title: 'Отмена',
                      onTap: Navigator.of(context).pop,
                    ),
                    OskButton.main(
                      title: 'Готово',
                      onTap: () {
                        Navigator.of(context).pop();
                        onPeriodChanged(dates);
                      },
                      state: doneButtonEnabled
                          ? OskButtonState.enabled
                          : OskButtonState.disabled,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
