part of 'bloc.dart';

sealed class ProductDataPageEvent {}

class ProductDataPageEventInitialize implements ProductDataPageEvent {}

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
  final List<String> codes;

  const ProductDataPageEventAddOrUpdateProduct({
    required this.name,
    required this.codes,
  });
}
