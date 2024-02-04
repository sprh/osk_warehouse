import 'package:flutter/material.dart';

import '../../theme/button/button_theme_extension.dart';
import '../../theme/utils/theme_from_context.dart';
import '../loading_effect/loading_effect.dart';
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

enum OskButtonState {
  disabled,
  loading,
  enabled;

  bool get isDisabled => this == OskButtonState.disabled;

  bool get isLoading => this == OskButtonState.loading;
}

class OskButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final OskButtonType type;
  final OskButtonState state;

  const OskButton._({
    required this.title,
    required this.onTap,
    required this.type,
    required this.state,
    super.key,
  });

  factory OskButton.main({
    required String title,
    required VoidCallback onTap,
    OskButtonState state = OskButtonState.enabled,
    Key? key,
  }) =>
      OskButton._(
        title: title,
        onTap: onTap,
        type: OskButtonType.main,
        state: state,
        key: key,
      );

  factory OskButton.minor({
    required String title,
    required VoidCallback onTap,
    OskButtonState state = OskButtonState.enabled,
    Key? key,
  }) =>
      OskButton._(
        title: title,
        onTap: onTap,
        type: OskButtonType.minor,
        state: state,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    final theme = type.getTheme(context);

    return Expanded(
      child: LoadingEffect(
        isLoading: state.isLoading,
        child: OskTapAnimationBuilder(
          onTap: onTap,
          disabled: state.isDisabled || state.isLoading,
          child: Container(
            decoration: BoxDecoration(
              color: state.isDisabled || state.isLoading
                  ? theme.disabledBackgroundColor
                  : theme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
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
      ),
    );
  }
}
