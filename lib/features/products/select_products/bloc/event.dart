part of 'bloc.dart';

sealed class SelectProductsEvent {
  const SelectProductsEvent();
}

class SelectProductsEventInitialize implements SelectProductsEvent {}

class SelectProductsEventDoneButtonTap implements SelectProductsEvent {}

class SelectProductsEventOnSelect implements SelectProductsEvent {
  final String id;

  const SelectProductsEventOnSelect(this.id);
}

class _SelectProductsEventOnData implements SelectProductsEvent {
  final List<Product> products;

  const _SelectProductsEventOnData(this.products);
}

class SelectProductsEventOpenSearch implements SelectProductsEvent {
  final ProductListSearchDataAvailable data;

  const SelectProductsEventOpenSearch(this.data);
}

class SelectProductsEventOnSearchUpdated implements SelectProductsEvent {
  final String? textToSearch;
  final String? selectedCategory;

  const SelectProductsEventOnSearchUpdated(
    this.textToSearch,
    this.selectedCategory,
  );
}
