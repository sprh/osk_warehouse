import 'package:flutter/material.dart';

import '../../../common/components/button/osk_button.dart';
import '../../../common/components/text/osk_text_field.dart';

class AddCategoryModalBottomSheet extends StatefulWidget {
  final void Function(String) onSaveTap;

  const AddCategoryModalBottomSheet({required this.onSaveTap, super.key});

  @override
  State<AddCategoryModalBottomSheet> createState() =>
      _AddCategoryModalBottomSheetState();
}

class _AddCategoryModalBottomSheetState
    extends State<AddCategoryModalBottomSheet> {
  String categoryName = '';
  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Flexible(
              child: OskTextField(
                hintText: 'Назовите категорию',
                textInputType: TextInputType.name,
                label: 'Название категории',
                initialText: categoryName,
                onChanged: _onTextChanged,
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OskButton.main(
                  title: 'Сохранить',
                  onTap: () => widget.onSaveTap(categoryName),
                  state: buttonEnabled
                      ? OskButtonState.enabled
                      : OskButtonState.disabled,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  void _onTextChanged(String category) {
    buttonEnabled = category.length > 2;
    categoryName = category;
    setState(() {});
  }
}
