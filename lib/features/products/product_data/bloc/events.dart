part of 'bloc.dart';

sealed class ProductDataPageEvent {}

class ProductDataPageEventInitialize implements ProductDataPageEvent {}

class ProductDataPageEventScanBarcode implements ProductDataPageEvent {}

class ProductDataPageEventDeleteBarcode implements ProductDataPageEvent {
  final String id;

  const ProductDataPageEventDeleteBarcode({required this.id});
}

class _ProductDataPageEventSetLoading implements ProductDataPageEvent {
  final bool loading;

  const _ProductDataPageEventSetLoading(this.loading);
}

class _ProductDataPageEventSetData implements ProductDataPageEvent {
  final Product? product;
  // final List<Warehouse> warehouses;

  const _ProductDataPageEventSetData({
    required this.product,
    // required this.warehouses,
  });
}

class ProductDataPageEventAddOrUpdateProduct implements ProductDataPageEvent {
  final String name;
  final ProductType? itemType;
  final String manufacturer;
  final String model;
  final String? description;
  final Set<String> codes;

  const ProductDataPageEventAddOrUpdateProduct({
    required this.name,
    required this.codes,
    required this.itemType,
    required this.manufacturer,
    required this.model,
    required this.description,
  });
}
