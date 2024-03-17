import '../../data/models/application/application_data_dto.dart';

class ApplicationSimpleWarehouse {
  final String warehouseName;
  final String address;

  const ApplicationSimpleWarehouse({
    required this.warehouseName,
    required this.address,
  });

  factory ApplicationSimpleWarehouse.fromDto(
    ApplicationSimpleWarehouseDto dto,
  ) =>
      ApplicationSimpleWarehouse(
        warehouseName: dto.warehouseName,
        address: dto.address,
      );
}
