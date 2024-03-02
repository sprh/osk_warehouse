import '../../models/product.dart';

sealed class ProductDataState {}

class ProductDataStateInitial implements ProductDataState {}

class ProductDataStateUpdate implements ProductDataState {
  final Product product;
  final bool loading;

  const ProductDataStateUpdate({
    required this.product,
    this.loading = false,
  });
}

class ProductDataStateCreate implements ProductDataState {
  final bool loading;

  const ProductDataStateCreate({
    this.loading = false,
  });
}
