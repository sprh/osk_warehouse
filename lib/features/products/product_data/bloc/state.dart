import '../../models/product.dart';

sealed class ProductDataState {}

class ProductDataStateInitial implements ProductDataState {}

class ProductDataStateUpdate implements ProductDataState {
  final Product product;
  final bool loading;
  final Set<String> barcodes;
  final bool showUpdateProductButton;

  const ProductDataStateUpdate({
    required this.product,
    required this.barcodes,
    required this.showUpdateProductButton,
    this.loading = false,
  });
}

class ProductDataStateCreate implements ProductDataState {
  final bool loading;
  final Set<String> barcodes;
  final bool showUpdateProductButton;

  const ProductDataStateCreate({
    required this.showUpdateProductButton,
    this.loading = false,
    this.barcodes = const <String>{},
  });
}
