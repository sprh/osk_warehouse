import 'package:flutter/material.dart';

import '../../theme/utils/theme_from_context.dart';
import '../tap/osk_tap_animation.dart';
import 'osk_icons.dart';

class OskIconButton extends StatelessWidget {
  final OskIcon icon;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const OskIconButton({
    required this.icon,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.iconButtonTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? theme.background,
      ),
      child: OskTapAnimationBuilder(
        onTap: onTap,
        child: SizedBox.square(
          dimension: 24,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
