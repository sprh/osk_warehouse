import 'package:flutter/material.dart';

import '../../theme/utils/theme_from_context.dart';
import '../../utils/kotlin_utils.dart';
import '../actions/actions_flex.dart';
import '../text/osk_text.dart';

class OskScaffold extends StatefulWidget {
  final List<Widget>? actions;
  final List<Widget> slivers;
  final Axis actionsDirection;
  final bool actionsShadow;
  final ScrollController? scrollController;
  final Widget? customActions;

  OskScaffold({
    required Widget body,
    this.actions,
    this.customActions,
    OskScaffoldHeader? header,
    SliverAppBar? appBar,
    this.actionsDirection = Axis.vertical,
    this.actionsShadow = false,
    this.scrollController,
    super.key,
  }) : slivers = [
          if (appBar != null) appBar,
          if (header != null)
            SliverToBoxAdapter(
              child: header,
            ),
          SliverToBoxAdapter(
            child: body,
          ),
        ];

  OskScaffold.slivers({
    required List<Widget> slivers,
    this.actions,
    OskScaffoldHeader? header,
    SliverAppBar? appBar,
    this.actionsDirection = Axis.vertical,
    this.actionsShadow = false,
    this.scrollController,
    this.customActions,
    super.key,
  }) : slivers = [
          if (appBar != null) appBar,
          if (header != null) SliverToBoxAdapter(child: header),
          ...slivers,
        ];

  @override
  State<StatefulWidget> createState() => _OskScaffoldState();
}

class _OskScaffoldState extends State<OskScaffold> {
  @override
  Widget build(BuildContext context) {
    final theme = context.scaffoldTheme;
    final globalTheme = Theme.of(context);
    final actionsWidget = widget.actions?.let(
          (actions) => OskActionsFlex(
            maxWidth: MediaQuery.of(context).size.width,
            widgets: actions,
            direction: widget.actionsDirection,
          ),
        ) ??
        widget.customActions;

    return Theme(
      data: globalTheme.copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
        appBarTheme: globalTheme.appBarTheme.copyWith(
          backgroundColor: theme.backgroundColor,
        ),
      ),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        body: CustomScrollView(
          controller: widget.scrollController,
          shrinkWrap: true,
          clipBehavior: Clip.none,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: widget.slivers,
        ),
        bottomNavigationBar: actionsWidget?.let(
          (actions) => DecoratedBox(
            decoration: BoxDecoration(
              color: theme.floatingActionsBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              boxShadow: [
                if (widget.actionsShadow)
                  BoxShadow(
                    blurRadius: 16,
                    color: theme.actionsShadow,
                  ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    MediaQuery.of(context).padding.bottom +
                    8,
              ),
              child: actions,
            ),
          ),
        ),
      ),
    );
  }
}

class OskScaffoldHeader extends StatelessWidget {
  final double expandedHeight;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;

  OskScaffoldHeader({
    String? title,
    this.leading,
    this.expandedHeight = 100,
    this.actions,
    super.key,
  }) : titleWidget = title == null
            ? null
            : OskText.title1(
                text: title,
                fontWeight: OskfontWeight.bold,
              );

  const OskScaffoldHeader.customTitle({
    required this.titleWidget,
    this.leading,
    this.expandedHeight = 100,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.scaffoldTheme;

    return SafeArea(
      bottom: false,
      child: ColoredBox(
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: 16),
                ],
                if (titleWidget != null)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65,
                    ),
                    child: titleWidget,
                  ),
                if (actions != null) ...[
                  const Spacer(),
                  Row(children: actions!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
