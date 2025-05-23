import 'package:flutter/material.dart';

import '../../../theme/utils/theme_from_context.dart';
import '../../tap/osk_tap_animation.dart';
import '../../text/osk_text.dart';

class OskDropdownButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String? selectedItemText;
  final Animation<double> iconAnimation;
  final bool showIcon;

  const OskDropdownButton({
    required this.label,
    required this.onTap,
    required this.iconAnimation,
    this.selectedItemText,
    this.showIcon = true,
    super.key,
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
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 54),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (selectedItemText == null)
                  OskText.body(
                    text: label,
                    colorType: OskTextColorType.minor,
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    child: OskText.body(text: selectedItemText!),
                  ),
                if (showIcon)
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
