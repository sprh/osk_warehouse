import '../../products/models/product.dart';

class OskCreateApplicationProduct {
  final Product product;
  final int count;
  final int? maxCount;

  const OskCreateApplicationProduct({
    required this.product,
    required this.count,
    this.maxCount,
  });

  OskCreateApplicationProduct copyWith({
    Product? product,
    int? count,
    int? maxCount,
  }) =>
      OskCreateApplicationProduct(
        product: product ?? this.product,
        count: count ?? this.count,
        maxCount: maxCount ?? this.maxCount,
      );
}
