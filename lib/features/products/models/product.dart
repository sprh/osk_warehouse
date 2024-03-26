import 'package:collection/collection.dart';

import '../data/api/models/product_dto.dart';

final class Product {
  final String id;
  final String name;
  final ProductType type;
  final String manufacturer;
  final String model;
  final String? description;
  final Set<String> codes;
  final int? count;
  final Map<String, int>? warehouseCount;

  const Product({
    required this.id,
    required this.name,
    required this.type,
    required this.manufacturer,
    required this.model,
    required this.description,
    required this.codes,
    this.count,
    this.warehouseCount,
  });

  factory Product.fromDto(ProductDto dto) => Product(
        id: dto.id,
        name: dto.itemName,
        type: ProductType.fromString(dto.itemType),
        codes: dto.codes.toSet(),
        count: dto.count,
        manufacturer: dto.manufacturer,
        model: dto.model,
        description: dto.description,
        warehouseCount: dto.warehouseCount,
      );
}

enum ProductType {
  other;

  static ProductType fromString(String value) =>
      ProductType.values.firstWhereOrNull(
        (element) => element.name == value,
      ) ??
      ProductType.other;
}
