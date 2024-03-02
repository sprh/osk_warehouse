import 'dart:collection';

class AccountScopeRouteState {
  final Queue<AccountScopeRoute> routes;

  const AccountScopeRouteState({
    required this.routes,
  });
}

sealed class AccountScopeRoute {
  const AccountScopeRoute();
}

class AccountScopeRouteMain extends AccountScopeRoute {}

class AccountScopeRouteUserData extends AccountScopeRoute {
  final String? username;

  const AccountScopeRouteUserData([this.username]);
}

class AccountScopeRouteWorkersList extends AccountScopeRoute {}

class AccountScopeRouteWarehouseData extends AccountScopeRoute {
  final String? warehouseId;

  const AccountScopeRouteWarehouseData([this.warehouseId]);
}

class AccountScopeRouteWarehouseList extends AccountScopeRoute {}

class AccountScopeRouteProductsList extends AccountScopeRoute {
  final String? warehouseId;

  const AccountScopeRouteProductsList([this.warehouseId]);
}

class AccountScopeRouteRequestsList extends AccountScopeRoute {}

class AccountScopeRouteRequestInfoPage extends AccountScopeRoute {
  final String requestId;

  const AccountScopeRouteRequestInfoPage({required this.requestId});
}

class AccountScopeRouteProductData extends AccountScopeRoute {
  final String? productId;

  const AccountScopeRouteProductData([this.productId]);
}
