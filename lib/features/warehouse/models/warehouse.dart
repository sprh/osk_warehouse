import '../data/api/models/warehouse_dto.dart';

class Warehouse {
  final String id;
  final String name;
  final String address;

  const Warehouse({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Warehouse.fromDto(WarehouseDto dto) => Warehouse(
        id: dto.id,
        address: dto.address,
        name: dto.warehouseName,
      );
}
