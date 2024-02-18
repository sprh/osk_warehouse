part of 'bloc.dart';

sealed class WarehouseDataBlocEvent {}

class WarehouseDataBlocInitializeEvent implements WarehouseDataBlocEvent {}

class WarehouseDataBlocCreateOrUpdateEvent implements WarehouseDataBlocEvent {
  final String name;
  final String address;

  const WarehouseDataBlocCreateOrUpdateEvent({
    required this.name,
    required this.address,
  });
}
