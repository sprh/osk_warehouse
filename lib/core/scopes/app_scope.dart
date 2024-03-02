import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../authorization/data/manager.dart';
import '../network/dio_client.dart';
import 'interface/scope.dart';

final class AppScope extends Scope {
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authManager;
  final DioClient dio;

  static final appScopeKey = GlobalKey();

  static AppScope of(BuildContext context) =>
      appScopeKey.currentWidget! as AppScope;

  AppScope({
    required this.secureStorage,
    required this.authManager,
    required this.dio,
    required super.child,
  }) : super(key: appScopeKey);
}
