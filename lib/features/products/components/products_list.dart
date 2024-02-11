// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';

import '../../../common/components/info_slot/osk_info_slot.dart';
import '../../../common/components/text/osk_text.dart';
import '../models/product.dart';

typedef OnProductAction = void Function(String id);

class ProductsList extends StatelessWidget {
  final List<Product> products;
  final OnProductAction onProductTap;
  final Set<String>? selectedProducts;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final OnProductAction? onSelected;

  const ProductsList({
    required this.products,
    required this.onProductTap,
    this.onDelete,
    this.onEdit,
    super.key,
  })  : selectedProducts = null,
        onSelected = null;

  const ProductsList.selectable({
    required this.products,
    required Set<String> selectedProducts,
    required OnProductAction onSelected,
    super.key,
  })  : selectedProducts = selectedProducts,
        onSelected = onSelected,
        onDelete = null,
        onEdit = null,
        onProductTap = onSelected;

  @override
  Widget build(BuildContext context) => Column(
        children: products
            .expand(
              (w) => [
                OskInfoSlot.dismissible(
                  title: w.name,
                  subtitle: w.description,
                  onTap: () => onProductTap(w.id),
                  dismissibleKey: ValueKey(w.id),
                  selected: selectedProducts?.contains(w.id),
                  onSelected: () => onSelected?.call(w.id),
                  onDelete: onDelete == null
                      ? null
                      : () {
                          onDelete!();
                          return Future.value(false);
                        },
                  onEdit: onEdit == null
                      ? null
                      : () {
                          onEdit!();
                          return Future.value(false);
                        },
                  leading: w.count == null
                      ? null
                      : OskText.caption(
                          text: '${w.count!} шт.', // TODO:
                          fontWeight: OskfontWeight.medium,
                        ),
                ),
                const SizedBox(height: 8),
              ],
            )
            .toList(),
      );
}
