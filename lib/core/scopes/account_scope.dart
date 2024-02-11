import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/warehouse/data/api/api.dart';
import '../../features/warehouse/data/repository.dart';
import '../authorization/data/manager.dart';
import '../navigation/logic/account_scope_routes_builder.dart';
import '../navigation/logic/models/account_scope_routes.dart';
import '../navigation/manager/navigation_manager.dart';
import '../network/dio_client.dart';
import 'interface/scope.dart';

final class AccountScope extends Scope {
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authManager;
  final DioClient dio;
  final AccountScopeNavigationManager navigationManager;

  static final _appScopeKey = GlobalKey();

  static AccountScope of(BuildContext context) =>
      _appScopeKey.currentWidget! as AccountScope;

  AccountScope({
    required this.secureStorage,
    required this.authManager,
    required this.dio,
    required super.navigatorKey,
    required this.navigationManager,
  }) : super(
          key: _appScopeKey,
          initialRoute: AccountScopeRoutes.main.name,
          onGenerateRoute: AccountScopeRoutesBuilder.generateRoutes,
        );

  late final warehouseApi = WarehouseApi(dio);
  late final warehouseRepository = WarehouseRepository(warehouseApi);
}
