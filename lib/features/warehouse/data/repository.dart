import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../utils/kotlin_utils.dart';
import '../models/warehouse.dart';
import 'api/api.dart';
import 'api/models/warehouse_create_request_dto.dart';

abstract class WarehouseRepository extends Repository<List<Warehouse>> {
  factory WarehouseRepository(WarehouseApi api) => _WarehouseRepository(api);

  Stream<Warehouse?> warehouseDataStreamById(String id);

  Future<void> refreshWarehouseList();

  Future<void> createWarehouse(String name, String address);
}

class _WarehouseRepository extends Repository<List<Warehouse>>
    implements WarehouseRepository {
  final WarehouseApi _api;

  _WarehouseRepository(this._api);

  @override
  Stream<Warehouse?> warehouseDataStreamById(String id) => dataStream.map(
        (list) => list.firstWhereOrNull(
          (element) => element.id == id,
        ),
      );

  @override
  Future<void> refreshWarehouseList() async {
    if (loading) {
      return;
    }

    await _api.getWarehouseList().callTrowable(
          onError: (error) =>
              emitError(RepositoryLocalizedError(message: 'todo')),
          onSuccess: (data) {
            final models = data.items.map(Warehouse.fromDto).toList();
            emit(models);
          },
        );
  }

  @override
  Future<void> createWarehouse(String name, String address) => _api
      .createWarehouse(
        WarehouseCreateRequestDto(address: address, warehouseName: name),
        const Uuid().v4(),
      )
      .callTrowable(
        onError: (error) => throw RepositoryLocalizedError(message: 'todo'),
        onSuccess: (dto) => refreshWarehouseList(),
      );
}
