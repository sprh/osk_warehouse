import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/applications/data/api/api.dart';
import '../../features/applications/data/repository/applications_list_repository.dart';
import '../../features/applications/data/repository/create_application_repository.dart';
import '../../features/products/data/api/api.dart';
import '../../features/products/data/product_list_repository.dart';
import '../../features/products/data/product_repository.dart';
import '../../features/user/current_user_holder/current_user_holder.dart';
import '../../features/user/data/api/api.dart';
import '../../features/user/data/user_list_repository.dart';
import '../../features/user/data/user_repository.dart';
import '../../features/warehouse/data/api/api.dart';
import '../../features/warehouse/data/repository.dart';
import '../authorization/data/manager.dart';
import '../network/dio_client.dart';
import 'interface/scope.dart';

final class AccountScope extends Scope {
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authManager;
  final DioClient dio;

  static final _appScopeKey = GlobalKey();

  static AccountScope of(BuildContext context) =>
      _appScopeKey.currentWidget! as AccountScope;

  AccountScope({
    required this.secureStorage,
    required this.authManager,
    required this.dio,
    required super.child,
  }) : super(key: _appScopeKey);

  late final warehouseApi = WarehouseApi(dio);
  late final warehouseRepository = WarehouseRepository(warehouseApi);

  late final userApi = UserApi(dio);
  late final userListRepository = UserListRepository(
    userApi,
    authManager.currentUsernameHolder,
  );

  late final userRepository = UserRepository(
    userApi,
    warehouseRepository,
    authManager.currentUsernameHolder,
    userListRepository,
  );

  late final productApi = ProductApi(dio);
  late final productListRepository = ProductListRepository(productApi);

  late final productRepository = ProductRepository(
    productApi,
    warehouseRepository,
    productListRepository,
  );

  late final currentUserHolder = CurrentUserHolder(
    authManager.currentUsernameHolder,
    userApi,
  );

  // application
  late final applicationsApi = ApplicationsApi(dio);

  // Create application
  late final createApplicationRepository = CreateApplicationRepository(
    applicationsApi,
  );

  // Applications list
  late final applicationsListRepository = ApplicationsListRepository(
    applicationsApi,
  );
}
