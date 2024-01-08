import 'package:flutter/material.dart';
import 'package:osk_warehouse/theme/utils/theme_from_context.dart';

class OskScaffold extends StatelessWidget {
  final Widget body;
  final List<Widget>? floatingActions;

  const OskScaffold({
    required this.body,
    this.floatingActions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.scaffoldTheme;
    final floatingActions = this.floatingActions;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActions != null
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: theme.floatingActionsBackgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: floatingActions,
              ),
            )
          : null,
      body: body,
    );
  }
}
