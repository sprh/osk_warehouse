import 'package:flutter/material.dart';

import '../../theme/utils/theme_from_context.dart';
import '../icon/osk_icons.dart';
import '../tap/osk_tap_animation.dart';
import '../text/osk_text.dart';

class OskInfoSlot extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  final Future<bool> Function()? onDelete;
  final Future<bool> Function()? onEdit;
  final Key? dismissibleKey;

  const OskInfoSlot({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.onDelete,
    this.onEdit,
    this.dismissibleKey,
    super.key,
  });

  DismissDirection get _dismissDirection {
    if (onDelete != null && onEdit != null) {
      return DismissDirection.horizontal;
    } else if (onDelete != null) {
      return DismissDirection.endToStart;
    } else if (onEdit != null) {
      return DismissDirection.startToEnd;
    }
    return DismissDirection.none;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.actionBlockTheme;

    return Dismissible(
      key: dismissibleKey ?? UniqueKey(),
      direction: _dismissDirection,
      background: Container(
        alignment: Alignment.centerLeft,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: OskIcon.edit(),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: OskIcon.delete(),
        ),
      ),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart && onDelete != null) {
          return onDelete!.call();
        } else if (direction == DismissDirection.startToEnd && onEdit != null) {
          return onEdit!.call();
        }
        return Future.value(false);
      },
      child: OskTapAnimationBuilder(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.blockShadowColor,
                blurRadius: 8,
              ),
            ],
            color: Colors.white,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: size.width / 10 * 9,
              maxWidth: size.width / 10 * 9,
              minHeight: size.height / 12,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OskText.body(
                      text: title,
                      fontWeight: OskfontWeight.medium,
                    ),
                    if (subtitle != null)
                      OskText.caption(
                        text: subtitle!,
                        colorType: OskTextColorType.minor,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
