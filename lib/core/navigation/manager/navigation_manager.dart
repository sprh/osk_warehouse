import 'package:flutter/material.dart';

import '../../../common/components/actions/actions_flex.dart';
import '../../../common/components/button/osk_button.dart';
import '../../../common/components/modal/modal_dialog.dart';
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

  void showSomethingWentWrontDialog(
    String message, {
    VoidCallback? onCloseTap,
  }) =>
      showModalDialog(
        title: 'Что-то пошло не так',
        subtitle: message,
        actions: OskActionsFlex(
          widgets: [
            OskButton.main(
              title: 'Закрыть',
              onTap: () {
                pop();
                onCloseTap?.call();
              },
            ),
          ],
        ),
      );
}