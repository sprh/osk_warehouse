import 'dart:core';

import '../../../category/models/item_category.dart';
import '../../models/product.dart';

class ProductListRepositoryData {
  final List<Product> products;
  final List<ItemCategory>? categories;

  const ProductListRepositoryData({
    required this.products,
    this.categories,
  });
}
