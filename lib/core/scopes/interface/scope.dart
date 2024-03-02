import 'package:flutter/material.dart';

base class Scope extends InheritedWidget {
  const Scope({
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
