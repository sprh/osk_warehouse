part of 'bloc.dart';

sealed class SelectProductsState {}

class SelectProductsStateIdle implements SelectProductsState {}

class SelectProductsStateData implements SelectProductsState {
  final List<Product> products;
  final Set<String> selectedProductIds;
  final ProductListSearchDataAvailable searchData;

  SelectProductsStateData(
    this.products,
    this.selectedProductIds,
    this.searchData,
  );

  SelectProductsStateData copyWith({
    List<Product>? products,
    Set<String>? selectedProductIds,
    ProductListSearchDataAvailable? searchData,
  }) =>
      SelectProductsStateData(
        products ?? this.products,
        selectedProductIds ?? this.selectedProductIds,
        searchData ?? this.searchData,
      );
}
