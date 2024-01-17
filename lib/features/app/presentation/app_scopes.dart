import 'package:flutter/widgets.dart';

import '../../navigation/logic/navigation_manager.dart';
import '../../navigation/scope/navigation_scope.dart';

class AppScopesWrapper extends StatelessWidget {
  final Widget child;

  const AppScopesWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) => NavigationScope(
        navigationManager: NavigationManager(),
        child: child,
      );
}
