import 'package:flutter/material.dart';

import 'dio_client.dart';

class NetworkScope extends InheritedWidget {
  final DioClient _dioClient;

  const NetworkScope(
    this._dioClient, {
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
