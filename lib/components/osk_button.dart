import 'package:flutter/material.dart';
import 'package:osk_warehouse/components/osk_tap_animation.dart';
import 'package:osk_warehouse/components/osk_text.dart';
import 'package:osk_warehouse/theme/button/button_theme_extension.dart';
import 'package:osk_warehouse/theme/utils/theme_from_context.dart';

enum OskButtonType {
  main;

  ButtonThemeExtension getTheme(BuildContext context) {
    switch (this) {
      case OskButtonType.main:
        return context.mainButtonTheme;
    }
  }
}

class OskButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final OskButtonType type;
  final bool disabled;
  final double sizeProportion;

  const OskButton._({
    required this.title,
    required this.onTap,
    required this.type,
    required this.disabled,
    required this.sizeProportion,
    super.key,
  });

  factory OskButton.main({
    required String title,
    required VoidCallback onTap,
    bool disabled = false,
    double sizeProportion = 1.0,
    Key? key,
  }) =>
      OskButton._(
        title: title,
        onTap: onTap,
        type: OskButtonType.main,
        disabled: disabled,
        sizeProportion: sizeProportion,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final theme = type.getTheme(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * sizeProportion,
      child: OskTapAnimationBuilder(
        onTap: onTap,
        disabled: disabled,
        child: Container(
          decoration: BoxDecoration(
            color: disabled
                ? theme.disabledBackgroundColor
                : theme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
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
