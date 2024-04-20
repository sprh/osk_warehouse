import 'dart:collection';

import '../../../../features/applications/models/application/application.dart';
import '../../../../features/products/select_products/bloc/bloc.dart';

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

class AccountScopeRouteApplicationsList extends AccountScopeRoute {}

class AccountScopeRouteCreateApplicationPage extends AccountScopeRoute {
  const AccountScopeRouteCreateApplicationPage();
}

class AccountScopeRouteEditApplicationPage extends AccountScopeRoute {
  final Application application;

  const AccountScopeRouteEditApplicationPage(this.application);
}

class AccountScopeRouteProductData extends AccountScopeRoute {
  final String? productId;

  const AccountScopeRouteProductData([this.productId]);
}

class AccountScopeRouteSelectProducts extends AccountScopeRoute {
  final OnSelectProducts onSelect;
  final String? warehouseId;
  final Set<String>? selectedProducts;

  const AccountScopeRouteSelectProducts(
    this.onSelect,
    this.warehouseId, [
    this.selectedProducts,
  ]);
}

class AccountScopeRouteApplicationData extends AccountScopeRoute {
  final String applicationId;

  AccountScopeRouteApplicationData(this.applicationId);
}

class AccountScopeRouteReports extends AccountScopeRoute {
  const AccountScopeRouteReports();
}
