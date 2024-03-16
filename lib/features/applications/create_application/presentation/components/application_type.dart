import 'package:flutter/material.dart';

import '../../../../../common/components/checkbox/osk_checkbox.dart';
import '../../../../../common/components/tap/osk_tap_animation.dart';
import '../../../../../common/components/text/osk_text.dart';
import '../../../../../theme/utils/theme_from_context.dart';

class SelectApplicationTypeWidget extends StatelessWidget {
  final bool selected;
  final String name;
  final VoidCallback onSelect;

  const SelectApplicationTypeWidget({
    required this.selected,
    required this.name,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.requestInfoTheme;
    final size = MediaQuery.of(context).size;

    return OskTapAnimationBuilder(
      onTap: onSelect,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: theme.shadow, blurRadius: 8),
          ],
          color: theme.background,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width / 10 * 9,
            maxWidth: size.width / 10 * 9,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OskText.body(
                  text: name,
                  fontWeight: OskfontWeight.bold,
                ),
                const SizedBox(height: 8),
                OskCheckbox(onSelect: onSelect, selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
