import '../../models/product.dart';

sealed class ProductListState {}

class ProductListInitialState implements ProductListState {}

class ProductListDataState implements ProductListState {
  final List<Product> products;
  final bool loading;

  const ProductListDataState(this.products, {this.loading = false});

  ProductListDataState copyWith({
    List<Product>? products,
    bool? loading,
  }) =>
      ProductListDataState(
        products ?? this.products,
        loading: loading ?? this.loading,
      );
}
