part of 'bloc.dart';

sealed class ProductListEvent {}

class ProductListEventInitialize implements ProductListEvent {}

class ProductListEventAddNewProduct implements ProductListEvent {}

class ProductListEventDeleteProduct implements ProductListEvent {
  final String id;

  const ProductListEventDeleteProduct(this.id);
}

class _ProductListUpdateStateEvent implements ProductListEvent {
  final List<Product>? products;
  final bool? loading;

  const _ProductListUpdateStateEvent({this.products, this.loading});
}

class ProductListProductTapEvent implements ProductListEvent {
  final String id;

  const ProductListProductTapEvent(this.id);
}

class ProductListEventOpenSearch implements ProductListEvent {
  final ProductListSearchDataAvailable data;

  const ProductListEventOpenSearch(this.data);
}

class ProductListEventOnSearchUpdated implements ProductListEvent {
  final String? textToSearch;
  final String? selectedCategory;

  const ProductListEventOnSearchUpdated(
    this.textToSearch,
    this.selectedCategory,
  );
}
