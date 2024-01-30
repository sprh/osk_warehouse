import 'package:flutter/material.dart';

import 'data/manager.dart';

class AuthorizationScope extends InheritedWidget {
  final AuthorizationDataManager _authorizationDataManager;

  static AuthorizationDataManager of(BuildContext context) => context
      .getInheritedWidgetOfExactType<AuthorizationScope>()!
      ._authorizationDataManager;

  const AuthorizationScope(
    this._authorizationDataManager, {
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
