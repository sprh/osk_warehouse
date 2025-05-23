import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '../../../common/interface/repository.dart';
import '../../../common/utils/kotlin_utils.dart';
import '../models/warehouse.dart';
import 'api/api.dart';
import 'api/models/warehouse_create_request_dto.dart';
import 'api/models/warehouse_dto.dart';

mixin WarehouseListGetter {
  Future<List<Warehouse>> get warehouseList;
}

mixin WarehouseListRefresher {
  Future<void> refreshWarehouseList();
}

abstract class WarehouseRepository extends Repository<List<Warehouse>>
    with WarehouseListGetter, WarehouseListRefresher {
  factory WarehouseRepository(WarehouseApi api) => _WarehouseRepository(api);

  Stream<Warehouse?> warehouseDataStreamById(String id);

  Future<Warehouse> getWarehouse(String id);

  Future<void> createWarehouse(String name, String address);

  Future<void> updateWarehouse(String name, String address, String id);

  Future<void> deleteWarehouse(String id);
}

class _WarehouseRepository extends Repository<List<Warehouse>>
    with WarehouseListGetter
    implements WarehouseRepository {
  final WarehouseApi _api;

  _WarehouseRepository(this._api);

  @override
  Future<List<Warehouse>> get warehouseList async =>
      lastValue ?? await _getWarehouseList();

  @override
  Stream<Warehouse?> warehouseDataStreamById(String id) => dataStream.map(
        (list) => list.firstWhereOrNull(
          (element) => element.id == id,
        ),
      );

  @override
  Future<Warehouse> getWarehouse(String id) async {
    try {
      final data = await _api.getWarehouse(id);
      return Warehouse.fromDto(data);
    } on Exception catch (e) {
      throw buildError(
        e: e,
        fallbackMessage:
            'Не удалось получить данные склада. Пожалуйста, попробуйте позже',
      );
    }
  }

  @override
  Future<void> refreshWarehouseList() async {
    if (loading) {
      return;
    }

    await _getWarehouseList().callTrowable(
      onError: (error) => onError(
        fallbackMessage: 'Не удалось обновить данные складов',
        e: error,
      ),
      onSuccess: emit,
    );
  }

  @override
  Future<void> createWarehouse(String name, String address) => _api
      .createWarehouse(
        WarehouseCreateRequestDto(address: address, warehouseName: name),
        const Uuid().v4(),
      )
      .callTrowable(
        onError: (error) => throw buildError(
          fallbackMessage:
              'Не удалось создать склад. Пожалуйста, повторите попытку позже',
          e: error,
        ),
        onSuccess: (dto) => refreshWarehouseList(),
      );

  @override
  Future<void> deleteWarehouse(String id) async =>
      _api.deleteWarehouse(id).callTrowable(
            onError: (error) => throw buildError(
              e: error,
              fallbackMessage:
                  'Не удалось удалить склад. Пожалуйста, повторите попытку позже',
            ),
            onSuccess: (dto) => refreshWarehouseList(),
          );

  @override
  Future<void> updateWarehouse(
    String name,
    String address,
    String id,
  ) async =>
      _api
          .updateWarehouse(
            WarehouseDto(warehouseName: name, address: address, id: id),
          )
          .callTrowable(
            onError: (error) => throw buildError(
              fallbackMessage:
                  'Не удалось обновить склад. Пожалуйста, повторите попытку позже',
              e: error,
            ),
            onSuccess: (dto) => refreshWarehouseList(),
          );

  Future<List<Warehouse>> _getWarehouseList() async {
    try {
      final data = await _api.getWarehouseList();
      return data.items.map(Warehouse.fromDto).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }
}
