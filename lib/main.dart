import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/authorization/bloc/authorization_data_bloc.dart';
import 'core/authorization/data/db.dart';
import 'core/authorization/data/manager.dart';
import 'core/authorization/data/repository.dart';
import 'core/network/dio_client.dart';
import 'features/app/presentation/osk_app.dart';
import 'features/observers/osk_bloc_observer.dart';
import 'features/observers/osk_flutter_error_observer.dart';
import 'utils/kotlin_utils.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      WidgetsBinding.instance.deferFirstFrame();
      await Firebase.initializeApp();
      Bloc.observer = OskBlocObserver();
      FlutterErrorObserver.setupErrorHandlers();

      final dioClient = _initializeNetwork();
      FirebaseCrashlytics.instance.crash();
      const secureStorage = FlutterSecureStorage();
      final authDataBloc = AuthorizationDataBloc();
      final authManager = _initializeAuthorizationDataScope(
        dioClient,
        secureStorage,
        authDataBloc,
      );

      await authManager.getCachedToken().callTrowable();

      runApp(
        BlocProvider(
          create: (_) => authDataBloc,
          child: OskApp(
            dio: dioClient,
            secureStorage: secureStorage,
            authDataManager: authManager,
          ),
        ),
      );

      WidgetsBinding.instance.allowFirstFrame();
    },
    (error, stackTrace) => FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
    ),
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
  AuthorizationDataBloc authDataBloc,
) {
  final db = AuthorizationDB(secureStorage);
  final repository = AuthorizationRepository(db, dio);
  final authorizationDataManager = AuthorizationDataManager(
    dio,
    repository,
    authDataBloc,
  );
  return authorizationDataManager;
}
