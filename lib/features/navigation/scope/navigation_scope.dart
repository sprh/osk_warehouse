import 'package:flutter/widgets.dart';

import '../logic/navigation_manager.dart';

class NavigationScope extends InheritedWidget {
  final NavigationManager _navigationManager;

  static NavigationManager of(BuildContext context) => context
      .getInheritedWidgetOfExactType<NavigationScope>()!
      ._navigationManager;

  const NavigationScope({
    required NavigationManager navigationManager,
    required super.child,
    super.key,
  }) : _navigationManager = navigationManager;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
