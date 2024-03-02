import '../data/api/models/product_dto.dart';

final class Product {
  final String id;
  final String name;
  final List<String> codes;
  final int? count;

  const Product({
    required this.id,
    required this.name,
    required this.codes,
    this.count,
  });

  factory Product.fromDto(ProductDto dto) => Product(
        id: dto.id,
        name: dto.itemName,
        codes: dto.codes,
        count: dto.count,
      );
}
