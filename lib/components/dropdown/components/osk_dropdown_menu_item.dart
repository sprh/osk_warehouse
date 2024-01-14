import 'package:flutter/material.dart';

import '../../../theme/utils/theme_from_context.dart';
import '../../tap/osk_tap_animation.dart';
import '../../text/osk_text.dart';

class OskDropdownMenuItem<T> {
  final String label;
  final T value;

  OskDropdownMenuItem({
    required this.label,
    required this.value,
  });
}

class OskDropdownItemWidget<T> extends StatelessWidget {
  final OskDropdownMenuItem<T> item;
  final Function(OskDropdownMenuItem<T>) onSelect;
  // Если itemSelected != null, то показывается чекбокс
  final bool? itemSelected;

  const OskDropdownItemWidget({
    required this.item,
    required this.onSelect,
    this.itemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dropdown;

    return OskTapAnimationBuilder(
      onTap: () => onSelect(item),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            if (itemSelected != null)
              SizedBox.square(
                dimension: 24,
                child: Checkbox(
                  checkColor: theme.checkboxBackground,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return theme.checkboxActiveBackground.withOpacity(.32);
                      }
                      return theme.checkboxActiveBackground;
                    },
                  ),
                  shape: CircleBorder(),
                  value: itemSelected,
                  onChanged: (_) => onSelect(item),
                ),
              ),
            SizedBox(width: 8),
            OskText.caption(
              text: item.label,
              fontWeight: OskfontWeight.medium,
            ),
          ],
        ),
      ),
    );
  }
}
