import 'package:flutter/material.dart';

import '../../checkbox/osk_checkbox.dart';
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
  final void Function(OskDropdownMenuItem<T>) onSelect;
  // Если itemSelected != null, то показывается чекбокс
  final bool? itemSelected;

  const OskDropdownItemWidget({
    required this.item,
    required this.onSelect,
    super.key,
    this.itemSelected,
  });

  @override
  Widget build(BuildContext context) => OskTapAnimationBuilder(
        onTap: () => onSelect(item),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              if (itemSelected != null)
                OskCheckbox(
                  onSelect: () => onSelect(item),
                  selected: itemSelected!,
                ),
              const SizedBox(width: 8),
              OskText.caption(
                text: item.label,
                fontWeight: OskfontWeight.medium,
              ),
            ],
          ),
        ),
      );
}
