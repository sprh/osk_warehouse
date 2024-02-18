import 'package:flutter/material.dart';

import 'components/osk_dropdown_animation_builder.dart';
import 'components/osk_dropdown_button.dart';
import 'components/osk_dropdown_list.dart';
import 'components/osk_dropdown_menu_item.dart';

class OskMultiSelectDropDownController<T> {
  final Set<T> _selectedValues = const {};

  OskMultiSelectDropDownController();

  Set<T> get selectedValues => _selectedValues;

  void addValue(T value) => _selectedValues.add(value);

  void removeValue(T value) => _selectedValues.remove(value);

  void clear() => _selectedValues.clear();
}

class OskMultiSelectDropDown<T> extends StatefulWidget {
  final List<OskDropdownMenuItem<T>> items;
  final void Function(Set<T>)? onSelectedItemsChanged;
  final String label;
  final Set<T> initialSelectedValues;

  final OskMultiSelectDropDownController<T>? controller;

  const OskMultiSelectDropDown({
    required this.items,
    required this.label,
    super.key,
    this.onSelectedItemsChanged,
    this.controller,
    this.initialSelectedValues = const {},
  });

  @override
  State createState() => _OskMultiSelectDropDownState<T>();
}

class _OskMultiSelectDropDownState<T> extends State<OskMultiSelectDropDown<T>>
    with SingleTickerProviderStateMixin, OskDropdownAnimationBuilder {
  late Set<T> selectedValues = widget.initialSelectedValues;

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
              selectedItemText: selectedValues.isEmpty
                  ? null
                  : widget.items
                      .where((item) => selectedValues.contains(item.value))
                      .map((item) => item.label)
                      .join(', '),
            ),
            OskDropdownList(
              animation: listExpand,
              widgets: widget.items
                  .map(
                    (e) => OskDropdownItemWidget<T>(
                      item: e,
                      onSelect: (item) {
                        final value = item.value;
                        if (selectedValues.contains(value)) {
                          selectedValues.remove(value);
                          widget.controller?.removeValue(value);
                        } else {
                          selectedValues.add(value);
                          widget.controller?.addValue(item.value);
                        }
                        widget.onSelectedItemsChanged?.call(selectedValues);

                        setState(() {});
                      },
                      itemSelected: selectedValues.contains(e.value),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
}
