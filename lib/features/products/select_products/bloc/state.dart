part of 'bloc.dart';

sealed class SelectProductsState {}

class SelectProductsStateIdle implements SelectProductsState {}

class SelectProductsStateData implements SelectProductsState {
  final List<Product> products;
  final Set<String> selectedProductIds;

  SelectProductsStateData(this.products, this.selectedProductIds);
}
