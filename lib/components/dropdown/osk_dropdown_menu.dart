import 'package:flutter/material.dart';

import 'components/osk_dropdown_animation_builder.dart';
import 'components/osk_dropdown_button.dart';
import 'components/osk_dropdown_list.dart';
import 'components/osk_dropdown_menu_item.dart';

class OskDropDownController<T> {
  T? selectedValue;

  OskDropDownController();

  void clear() => selectedValue = null;
}

class OskDropDown<T> extends StatefulWidget {
  final List<OskDropdownMenuItem<T>> items;
  final void Function(T)? onSelectedItemChanged;
  final String label;

  final OskDropDownController<T>? controller;

  const OskDropDown({
    required this.items,
    required this.label,
    this.onSelectedItemChanged,
    this.controller,
    super.key,
  });

  @override
  State createState() => _OskDropDownState<T>();
}

class _OskDropDownState<T> extends State<OskDropDown<T>>
    with SingleTickerProviderStateMixin, OskDropdownAnimationBuilder {
  OskDropdownMenuItem<T>? selectedValue;

  @override
  TickerProvider get vsync => this;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            OskDropdownButton(
              label: widget.label,
              iconAnimation: iconTurns,
              onTap: onChangeExpansion,
              selectedItemText: selectedValue?.label,
            ),
            OskDropdownList(
              animation: listExpand,
              widgets: widget.items
                  .map(
                    (e) => OskDropdownItemWidget<T>(
                      item: e,
                      onSelect: (item) {
                        selectedValue = item;
                        widget.controller?.selectedValue = item.value;
                        widget.onSelectedItemChanged?.call(item.value);

                        setState(() {});
                      },
                      itemSelected: selectedValue?.value == e.value,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
}
