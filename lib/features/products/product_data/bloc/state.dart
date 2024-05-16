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

  ProductDataStateUpdate copyWith({
    Product? product,
    bool? loading,
    Set<String>? barcodes,
    bool? showUpdateProductButton,
  }) =>
      ProductDataStateUpdate(
        product: product ?? this.product,
        barcodes: barcodes ?? this.barcodes,
        showUpdateProductButton:
            showUpdateProductButton ?? this.showUpdateProductButton,
        loading: loading ?? this.loading,
      );
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

  ProductDataStateCreate copyWith({
    bool? loading,
    Set<String>? barcodes,
    bool? showUpdateProductButton,
  }) =>
      ProductDataStateCreate(
        loading: loading ?? this.loading,
        barcodes: barcodes ?? this.barcodes,
        showUpdateProductButton:
            showUpdateProductButton ?? this.showUpdateProductButton,
      );
}
