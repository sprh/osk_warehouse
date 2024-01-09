import 'package:flutter/material.dart';

import '../theme/utils/theme_from_context.dart';
import 'osk_service_icons.dart';
import 'osk_tap_animation.dart';
import 'osk_text.dart';

class OskActionBlock extends StatelessWidget {
  final String title;
  final OskServiceIcon icon;
  final VoidCallback onTap;
  final int? notificationsCount;

  const OskActionBlock({
    required this.title,
    required this.icon,
    required this.onTap,
    this.notificationsCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.actionBlockTheme;

    return OskTapAnimationBuilder(
      onTap: onTap,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: theme.blockShadowColor,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: theme.blockBackgroundColor,
                ),
                height: 130, // TODO(sktimokhina): depends on screen size?
                width: 140,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: OskText.body(
                    text: title,
                    fontWeight: OskfontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: _NotificationBadge(notificationsCount),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  final int? notificationsCount;

  const _NotificationBadge(this.notificationsCount);

  @override
  Widget build(BuildContext context) {
    final notificationsCount = this.notificationsCount;
    final theme = context.actionBlockTheme;

    if (notificationsCount == 0 || notificationsCount == null) {
      return SizedBox(
        height: 24,
        width: 24,
      );
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.notificationIconBorderColor,
          width: 1,
        ),
        color: theme.notificationIconBackgroundColor,
      ),
      constraints: BoxConstraints(
        minHeight: 24,
        minWidth: 24,
      ),
      child: Center(
        child: notificationsCount <= 9
            ? OskText.body(
                text: '9',
                fontWeight: OskfontWeight.bold,
              )
            : OskText.caption(
                text: '9+',
                fontWeight: OskfontWeight.bold,
              ),
      ),
    );
  }
}
