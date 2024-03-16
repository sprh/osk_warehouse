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
  final OnProductAction? onDelete;
  final OnProductAction? onEdit;
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
  Widget build(BuildContext context) => SliverList.separated(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];

          return Center(
            child: OskInfoSlot.dismissible(
              title: product.name,
              onTap: () => onProductTap(product.id),
              dismissibleKey: ValueKey(product.id),
              selected: selectedProducts?.contains(product.id),
              onSelected: () => onSelected?.call(product.id),
              onDelete: onDelete == null
                  ? null
                  : () {
                      onDelete!(product.id);
                      return Future.value(false);
                    },
              onEdit: onEdit == null
                  ? null
                  : () {
                      onEdit!(product.id);
                      return Future.value(false);
                    },
              trailing: product.count == null
                  ? null
                  : OskText.caption(
                      text: '${product.count!} шт.', // TODO:
                      fontWeight: OskfontWeight.medium,
                    ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      );
}
