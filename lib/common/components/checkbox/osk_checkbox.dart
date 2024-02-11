import 'package:flutter/material.dart';

import '../../../theme/utils/theme_from_context.dart';

class OskCheckbox extends StatelessWidget {
  final bool selected;
  final VoidCallback onSelect;

  const OskCheckbox({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.checkboxTheme;

    return SizedBox.square(
      dimension: 24,
      child: Checkbox(
        checkColor: theme.background,
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return theme.activeBackground.withOpacity(.32);
            }
            return theme.activeBackground;
          },
        ),
        shape: const CircleBorder(),
        value: selected,
        onChanged: (_) => onSelect(),
      ),
    );
  }
}
