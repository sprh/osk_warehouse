import 'package:flutter/material.dart';

import '../../../theme/utils/theme_from_context.dart';
import '../../tap/osk_tap_animation.dart';
import '../../text/osk_text.dart';

class OskDropdownButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String? selectedItemText;
  final Animation<double> iconAnimation;

  const OskDropdownButton({
    required this.label,
    required this.onTap,
    required this.iconAnimation,
    this.selectedItemText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dropdownTheme;

    return OskTapAnimationBuilder(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.borderSideColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 54),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (selectedItemText == null)
                  OskText.body(
                    text: label,
                    colorType: OskTextColorType.minor,
                  )
                else
                  OskText.body(text: selectedItemText!),
                RotationTransition(
                  turns: iconAnimation,
                  child: Icon(
                    Icons.expand_more,
                    color: theme.borderSideColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
