import 'package:flutter/material.dart';

import '../../../components/actions/actions_flex.dart';
import '../../../components/modal/modal_dialog.dart';
import '../../../theme/utils/theme_from_context.dart';
import '../logic/models/account_scope_routes.dart';
import '../logic/models/routes.dart';

part 'account_scope_navigation_manager.dart';
part 'app_scope_navigation_manager.dart';

abstract class NavigationManager {
  final GlobalKey<NavigatorState> navigatorKey;

  const NavigationManager(this.navigatorKey);

  void pop() => navigatorKey.currentState?.pop();

  void showModalDialog({
    required String title,
    String? subtitle,
    OskActionsFlex? actions,
    bool dismissible = false,
  }) {
    final context = navigatorKey.currentState?.context;
    if (context != null) {
      showDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        barrierColor: context.modalDialogTheme.barrierColor,
        builder: (context) => PopScope(
          canPop: dismissible,
          child: ModalDialog(
            title: title,
            subtitle: subtitle,
            actions: actions,
          ),
        ),
      );
    }
  }
}
