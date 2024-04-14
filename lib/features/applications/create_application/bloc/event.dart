part of 'bloc.dart';

sealed class CreateApplicationEvent {}

class CreateApplicationEventInitialize implements CreateApplicationEvent {}

class CreateApplicationEventSelectProductsButtonTap
    implements CreateApplicationEvent {}

class CreateApplicationEventOnTypeSelected implements CreateApplicationEvent {
  final CreateApplicationApplicationType type;

  const CreateApplicationEventOnTypeSelected(this.type);
}

class CreateApplicationEventOnToWarehouseSelected
    implements CreateApplicationEvent {
  final Warehouse warehouse;

  const CreateApplicationEventOnToWarehouseSelected(this.warehouse);
}

class CreateApplicationEventOnFromWarehouseSelected
    implements CreateApplicationEvent {
  final Warehouse? warehouse;

  const CreateApplicationEventOnFromWarehouseSelected(this.warehouse);
}

class CreateApplicationEventRemoveProduct implements CreateApplicationEvent {
  final String id;

  const CreateApplicationEventRemoveProduct(this.id);
}

class CreateApplicationEventChangeCount implements CreateApplicationEvent {
  final String id;
  final int count;

  const CreateApplicationEventChangeCount(this.id, this.count);
}

class CreateApplicationEventOnShowFinalScreen
    implements CreateApplicationEvent {}

class CreateApplicationSaveButtonTap implements CreateApplicationEvent {
  const CreateApplicationSaveButtonTap();
}

class _CreateApplicationEventProductsSelected
    implements CreateApplicationEvent {
  final List<Product> products;

  _CreateApplicationEventProductsSelected({
    required this.products,
  });
}

class CreateApplicationEventShowPreviousStep
    implements CreateApplicationEvent {}

class CreateApplicationOnDescriptionChanged implements CreateApplicationEvent {
  final String description;

  const CreateApplicationOnDescriptionChanged({
    required this.description,
  });
}
