import '../../models/product.dart';

sealed class ProductListState {
  ProductListSearchDataAvailable? get availableSearchData {
    final data = this;
    if (data is ProductListDataState) {
      final searchData = data.searchData;
      if (searchData is ProductListSearchDataAvailable) {
        return searchData;
      }
    }

    return null;
  }

  const ProductListState();
}

class ProductListInitialState extends ProductListState {}

class ProductListDataState extends ProductListState {
  final List<Product> products;
  final bool loading;
  final bool showCreateProductButton;
  // Только для товаров склада
  final ProductListSearchData searchData;

  const ProductListDataState(
    this.products, {
    required this.showCreateProductButton,
    required this.searchData,
    this.loading = false,
  });

  ProductListDataState copyWith({
    List<Product>? products,
    bool? loading,
    bool? showCreateProductButton,
    ProductListSearchData? searchData,
  }) =>
      ProductListDataState(
        products ?? this.products,
        loading: loading ?? this.loading,
        showCreateProductButton:
            showCreateProductButton ?? this.showCreateProductButton,
        searchData: searchData ?? this.searchData,
      );
}

sealed class ProductListSearchData {
  const ProductListSearchData();
}

class ProductListSearchDataNotAvailable extends ProductListSearchData {
  const ProductListSearchDataNotAvailable();
}

class ProductListSearchDataAvailable extends ProductListSearchData {
  final String? productName;
  final String? selectedCategory;

  bool get hasActiveSearch => productName != null || selectedCategory != null;

  const ProductListSearchDataAvailable({
    this.productName,
    this.selectedCategory,
  });

  ProductListSearchDataAvailable copyWith({
    String? productName,
    String? selectedCategory,
  }) =>
      ProductListSearchDataAvailable(
        productName: productName ?? this.productName,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );
}
