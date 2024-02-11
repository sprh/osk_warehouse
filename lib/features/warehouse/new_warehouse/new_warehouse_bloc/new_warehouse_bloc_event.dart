part of 'new_warehouse_bloc.dart';

sealed class NewWarehouseBlocEvent {}

class NewWarehouseBlocCreateEvent implements NewWarehouseBlocEvent {
  final String name;
  final String address;

  const NewWarehouseBlocCreateEvent({
    required this.name,
    required this.address,
  });
}
