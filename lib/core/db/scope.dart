import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DBScope extends InheritedWidget {
  final FlutterSecureStorage _secureStorage;

  const DBScope(this._secureStorage, {required super.child, super.key});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
