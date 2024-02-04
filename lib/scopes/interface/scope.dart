import 'package:flutter/material.dart';

abstract base class Scope extends InheritedWidget {
  const Scope({required super.child, super.key});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
