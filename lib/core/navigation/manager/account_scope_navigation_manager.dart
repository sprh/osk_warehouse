part of 'navigation_manager.dart';

abstract class AccountScopeNavigationManager implements NavigationManager {
  factory AccountScopeNavigationManager(
    GlobalKey<NavigatorState> navigatorKey,
  ) =>
      _AccountScopeNavigationManager(navigatorKey);

  void openMain();

  // Workers
  void openUserData([String? username]);

  void openWorkersList();

  // Warehouse
  void openWarehouseList();

  void openWarehouseData([String? warehouseId]);

  // Products
  void openProductsList([String? warehouseId]);

  // Requests
  void openRequestsList();

  void openRequestInfoPage(String requestId);
}

class _AccountScopeNavigationManager extends NavigationManager
    implements AccountScopeNavigationManager {
  _AccountScopeNavigationManager(super.navigatorKey);

  @override
  void openMain() => navigatorKey.currentState?.pushReplacementNamed(
        AccountScopeRoutes.main.name,
      );

  @override
  void openUserData([String? username]) => navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.userData.name,
        arguments: username,
      );

  @override
  void openWorkersList() => navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.workersList.name,
      );

  @override
  void openWarehouseData([String? warehouseId]) =>
      navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.warehouseData.name,
        arguments: warehouseId,
      );

  @override
  void openWarehouseList() => navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.warehouseList.name,
      );

  @override
  void openProductsList([String? warehouseId]) =>
      navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.producsList.name,
        arguments: warehouseId,
      );

  @override
  void openRequestsList() => navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.requestsList.name,
      );

  @override
  void openRequestInfoPage(String requestId) =>
      navigatorKey.currentState?.pushNamed(
        AccountScopeRoutes.requestInfo.name,
        arguments: requestId,
      );
}
