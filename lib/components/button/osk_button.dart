import 'package:flutter/material.dart';

import '../../theme/button/button_theme_extension.dart';
import '../../theme/utils/theme_from_context.dart';
import '../tap/osk_tap_animation.dart';
import '../text/osk_text.dart';

enum OskButtonType {
  main,
  minor;

  ButtonThemeExtension getTheme(BuildContext context) {
    switch (this) {
      case OskButtonType.main:
        return context.mainButtonTheme;
      case OskButtonType.minor:
        return context.minorButtonTheme;
    }
  }
}

class OskButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final OskButtonType type;
  final bool disabled;

  const OskButton._({
    required this.title,
    required this.onTap,
    required this.type,
    required this.disabled,
    super.key,
  });

  factory OskButton.main({
    required String title,
    required VoidCallback onTap,
    bool disabled = false,
    Key? key,
  }) =>
      OskButton._(
        title: title,
        onTap: onTap,
        type: OskButtonType.main,
        disabled: disabled,
        key: key,
      );

  factory OskButton.minor({
    required String title,
    required VoidCallback onTap,
    bool disabled = false,
    Key? key,
  }) =>
      OskButton._(
        title: title,
        onTap: onTap,
        type: OskButtonType.minor,
        disabled: disabled,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final theme = type.getTheme(context);

    return Expanded(
      child: OskTapAnimationBuilder(
        onTap: onTap,
        disabled: disabled,
        child: Container(
          decoration: BoxDecoration(
            color: disabled
                ? theme.disabledBackgroundColor
                : theme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.0,
              color: theme.borderColor,
            ),
          ),
          height: 54, // TODO(sktimokhina): maybe depend on screen size?
          child: Center(
            child: OskText.body(
              text: title,
            ),
          ),
        ),
      ),
    );
  }
}
