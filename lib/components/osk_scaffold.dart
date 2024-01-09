import 'package:flutter/material.dart';

import '../theme/utils/theme_from_context.dart';

class OskScaffold extends StatelessWidget {
  final Widget body;
  final List<Widget>? floatingActions;
  final AppBar? appBar;

  const OskScaffold({
    required this.body,
    this.floatingActions,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.scaffoldTheme;
    final globalTheme = Theme.of(context);
    final floatingActions = this.floatingActions;

    return Theme(
      data: globalTheme.copyWith(
        appBarTheme: globalTheme.appBarTheme.copyWith(
          backgroundColor: theme.backgroundColor,
        ),
      ),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: appBar,
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
      ),
    );
  }
}
