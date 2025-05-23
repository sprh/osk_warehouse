import 'package:collection/collection.dart';
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
  final void Function(T?)? onSelectedItemChanged;
  final String label;
  final T? selectedValue;

  final OskDropDownController<T>? controller;

  const OskDropDown({
    required this.items,
    required this.label,
    this.onSelectedItemChanged,
    this.controller,
    this.selectedValue,
    super.key,
  });

  @override
  State createState() => _OskDropDownState<T>();
}

class _OskDropDownState<T> extends State<OskDropDown<T>>
    with SingleTickerProviderStateMixin, OskDropdownAnimationBuilder {
  late OskDropdownMenuItem<T>? selectedValue = widget.items.firstWhereOrNull(
    (item) => item.value == widget.selectedValue,
  );

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
              showIcon: widget.items.isNotEmpty,
            ),
            OskDropdownList(
              animation: listExpand,
              widgets: widget.items
                  .map(
                    (e) => OskDropdownItemWidget<T>(
                      item: e,
                      onSelect: (item) {
                        if (selectedValue?.value == item.value) {
                          selectedValue = null;
                        } else {
                          selectedValue = item;
                        }
                        widget.controller?.selectedValue = selectedValue?.value;
                        widget.onSelectedItemChanged
                            ?.call(selectedValue?.value);
                        onChangeExpansion();

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
