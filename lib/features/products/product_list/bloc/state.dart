import '../../models/product.dart';

sealed class ProductListState {}

class ProductListInitialState implements ProductListState {}

class ProductListDataState implements ProductListState {
  final List<Product> products;
  final bool loading;
  final bool showCreateProductButton;

  const ProductListDataState(
    this.products, {
    required this.showCreateProductButton,
    this.loading = false,
  });

  ProductListDataState copyWith({
    List<Product>? products,
    bool? loading,
    bool? showCreateProductButton,
  }) =>
      ProductListDataState(
        products ?? this.products,
        loading: loading ?? this.loading,
        showCreateProductButton:
            showCreateProductButton ?? this.showCreateProductButton,
      );
}
