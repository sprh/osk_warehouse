import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/authorization/authorization_scope.dart';
import 'core/authorization/data/db.dart';
import 'core/authorization/data/manager.dart';
import 'core/authorization/data/repository.dart';
import 'core/db/scope.dart';
import 'core/network/dio_client.dart';
import 'core/network/network_scope.dart';
import 'features/app/presentation/osk_app.dart';
import 'features/navigation/logic/models/routes.dart';
import 'features/observers/osk_bloc_observer.dart';
import 'features/observers/osk_flutter_error_observer.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      WidgetsBinding.instance.deferFirstFrame();
      Bloc.observer = OskBlocObserver();
      FlutterErrorObserver.setupErrorHandlers();

      final dioClient = _initializeNetwork();
      const secureStorage = FlutterSecureStorage();
      final authManager = _initializeAuthorizationDataScope(
        dioClient,
        secureStorage,
      );

      final token = await authManager.getCachedToken();
      runApp(
        AuthorizationScope(
          authManager,
          child: DBScope(
            secureStorage,
            child: NetworkScope(
              dioClient,
              child: OskApp(
                initialRoute: token ? Routes.main : Routes.login,
              ),
            ),
          ),
        ),
      );

      WidgetsBinding.instance.allowFirstFrame();
    },
    (_, __) {}, // TODO
  );
}

DioClient _initializeNetwork() {
  final dio = Dio();
  final client = DioClient(dio)..initialize();

  return client;
}

AuthorizationDataManager _initializeAuthorizationDataScope(
  DioClient dio,
  FlutterSecureStorage secureStorage,
) {
  final db = AuthorizationDB(secureStorage);
  final repository = AuthorizationRepository(db, dio);
  final authorizationDataManager = AuthorizationDataManager(dio, repository);
  return authorizationDataManager;
}
