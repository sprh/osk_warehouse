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
  final void Function(List<T>)? onSelectedItemsChanged;
  final String label;

  final OskMultiSelectDropDownController<T>? controller;

  const OskMultiSelectDropDown({
    required this.items,
    required this.label,
    super.key,
    this.onSelectedItemsChanged,
    this.controller,
  });

  @override
  State createState() => _OskMultiSelectDropDownState<T>();
}

class _OskMultiSelectDropDownState<T> extends State<OskMultiSelectDropDown<T>>
    with SingleTickerProviderStateMixin, OskDropdownAnimationBuilder {
  List<T> get selectedValues => listOFSelectedItem.map((e) => e.value).toList();

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
              selectedItemText:
                  listOFSelectedItem.isEmpty ? null : selectedValues.join(', '),
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
                          widget.controller?.removeValue(item.value);
                        } else {
                          listOFSelectedItem.add(item);
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
