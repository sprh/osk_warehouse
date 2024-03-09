import '../../models/product.dart';

sealed class ProductDataState {}

class ProductDataStateInitial implements ProductDataState {}

class ProductDataStateUpdate implements ProductDataState {
  final Product product;
  final bool loading;
  final Set<String> barcodes;

  const ProductDataStateUpdate({
    required this.product,
    required this.barcodes,
    this.loading = false,
  });
}

class ProductDataStateCreate implements ProductDataState {
  final bool loading;
  final Set<String> barcodes;

  const ProductDataStateCreate({
    this.loading = false,
    this.barcodes = const <String>{},
  });
}
