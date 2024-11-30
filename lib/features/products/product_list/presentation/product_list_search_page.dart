import 'package:flutter/material.dart';

import '../../../../common/components/actions/actions_flex.dart';
import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/text/osk_text.dart';
import '../../../../common/components/text/osk_text_field.dart';
import '../../../category/presentation/categories_list_dropdown_item.dart';
import '../bloc/state.dart';

class ProductListSearchBottomPane extends StatefulWidget {
  final ProductListSearchDataAvailable data;
  final void Function(String? textToSearch, String? selectedCategory)
      onSearchUpdated;

  const ProductListSearchBottomPane({
    required this.data,
    required this.onSearchUpdated,
    super.key,
  });

  @override
  State<ProductListSearchBottomPane> createState() =>
      _ProductListSearchBottomPaneState();
}

class _ProductListSearchBottomPaneState
    extends State<ProductListSearchBottomPane> {
  late String? itemCategory = widget.data.selectedCategory;
  late String? productName = widget.data.productName;
  late final bool hadSearch =
      widget.data.selectedCategory != null || widget.data.productName != null;

  bool canSaveSearch = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OskText.title1(
                text: 'Введите параметры для поиска товаров',
                fontWeight: OskfontWeight.bold,
              ),
              const SizedBox(height: 8),
              OskTextField(
                hintText: 'Аврора - 1',
                label: 'Текст для поиска',
                initialText: widget.data.productName,
                onChanged: _onSearchTextChanged,
              ),
              const SizedBox(height: 8),
              OskText.body(text: 'Категория для поиска:'),
              CategoriesListDropdownItem(
                selectedCategory: widget.data.selectedCategory,
                canAddCategory: false,
                onSelectedCategoryChanged: _onCategoryChanged,
              ),
              const SizedBox(height: 16),
              OskActionsFlex(
                maxWidth: MediaQuery.of(context).size.width,
                widgets: [
                  OskButton.main(
                    title: 'Искать',
                    onTap: () => widget.onSearchUpdated(
                      productName,
                      itemCategory,
                    ),
                    state: canSaveSearch
                        ? OskButtonState.enabled
                        : OskButtonState.disabled,
                  ),
                  if (hadSearch)
                    OskButton.main(
                      title: 'Очистить поиск',
                      onTap: () => widget.onSearchUpdated(null, null),
                    ),
                ],
              ),
            ],
          ),
        ),
      );

  void _onSearchTextChanged(String text) {
    productName = text;
    final canSearch = productName != null || itemCategory != null;
    final searchParamsChanged = productName != widget.data.productName ||
        itemCategory != widget.data.selectedCategory;
    canSaveSearch = canSearch || searchParamsChanged;
    setState(() {});
  }

  void _onCategoryChanged(String? category) {
    itemCategory = category;
    final canSearch = productName != null || itemCategory != null;
    final searchParamsChanged = productName != widget.data.productName ||
        itemCategory != widget.data.selectedCategory;
    canSaveSearch = canSearch || searchParamsChanged;
    setState(() {});
  }
}
