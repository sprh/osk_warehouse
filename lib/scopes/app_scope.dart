import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/authorization/data/manager.dart';
import '../core/network/dio_client.dart';
import '../features/navigation/logic/navigation_manager.dart';
import 'interface/scope.dart';

final class AppScope extends Scope {
  final FlutterSecureStorage secureStorage;
  final AuthorizationDataManager authManager;
  final DioClient dio;
  final NavigationManager navigationManager;

  static AppScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType()!;

  const AppScope({
    required this.secureStorage,
    required this.authManager,
    required this.dio,
    required this.navigationManager,
    required super.child,
    super.key,
  });
}
