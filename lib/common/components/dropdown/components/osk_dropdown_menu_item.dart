import 'package:flutter/material.dart';

import '../../../utils/kotlin_utils.dart';
import '../../checkbox/osk_checkbox.dart';
import '../../tap/osk_tap_animation.dart';
import '../../text/osk_text.dart';

class OskDropdownMenuItem<T> {
  final String label;
  final String? details;
  final T value;

  OskDropdownMenuItem({
    required this.label,
    required this.value,
    this.details,
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
    this.itemSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) => OskTapAnimationBuilder(
        onTap: () => onSelect(item),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: LayoutBuilder(
            builder: (_, constraints) => Row(
              children: [
                if (itemSelected != null)
                  OskCheckbox(
                    onSelect: () => onSelect(item),
                    selected: itemSelected!,
                  ),
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth - 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OskText.body(
                        text: item.label,
                        fontWeight: OskfontWeight.medium,
                      ),
                      item.details?.let(
                            (detail) => OskText.caption(
                              text: detail,
                              colorType: OskTextColorType.minor,
                            ),
                          ) ??
                          const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
