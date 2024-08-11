import 'package:flutter/material.dart';

import '../../../common/components/actions/actions_flex.dart';
import '../../../common/components/button/osk_button.dart';
import '../../../common/components/modal/modal_dialog.dart';
import '../../../common/theme/utils/theme_from_context.dart';

mixin NavigationManager {
  GlobalKey<NavigatorState> get navigatorKey;

  bool get canPop => navigatorKey.currentState?.canPop() ?? false;

  void pop();

  void popDialog() => navigatorKey.currentState?.pop();

  Future<void> showModalDialog({
    required String title,
    String? subtitle,
    OskActionsFlex? actions,
    bool dismissible = false,
  }) async {
    final context = navigatorKey.currentState?.context;
    if (context != null) {
      return showDialog<void>(
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

  Future<void> showSomethingWentWrontDialog(
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
                popDialog();
                onCloseTap?.call();
              },
            ),
          ],
        ),
      );

  void showModal(Widget Function(BuildContext) builder) {
    final context = navigatorKey.currentState?.context;

    if (context != null) {
      showModalBottomSheet<void>(
        context: context,
        builder: builder,
        isScrollControlled: true,
      );
    }
  }
}
