import 'package:flutter/material.dart';

import 'components/osk_dropdown_animation_builder.dart';
import 'components/osk_dropdown_button.dart';
import 'components/osk_dropdown_list.dart';
import 'components/osk_dropdown_menu_item.dart';

class DropDownController<T> {
  T? selectedValue;

  DropDownController() : selectedValue = null;

  void clear() => selectedValue = null;
}

class DropDown<T> extends StatefulWidget {
  final List<OskDropdownMenuItem<T>> items;
  final void Function(T)? onSelectedItemChanged;
  final String label;

  final DropDownController<T>? controller;

  const DropDown({
    required this.items,
    required this.label,
    this.onSelectedItemChanged,
    this.controller,
    super.key,
  });

  @override
  State createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>>
    with SingleTickerProviderStateMixin, OskDropdownAnimationBuilder {
  DropDown<T>? selectedValue;

  late Set<OskDropdownMenuItem<T>> listOFSelectedItem = {};

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
                        if (listOFSelectedItem.contains(item)) {
                          listOFSelectedItem.remove(item);
                          widget.controller?.selectedValue = item.value;
                        } else {
                          listOFSelectedItem.add(item);
                          widget.controller?.selectedValue = item.value;
                        }
                        widget.onSelectedItemChanged?.call(item.value);

                        setState(() => expanded = false);
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
}
