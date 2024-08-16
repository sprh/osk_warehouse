import 'package:uuid/uuid.dart';

import '../../../../common/interface/repository.dart';
import '../../../products/data/api/models/product_dto.dart';
import '../../models/create_application/create_application_application_type.dart';
import '../../models/osk_create_application_product.dart';
import '../api/api.dart';
import '../models/create_application/create_application_data_dto.dart';
import '../models/create_application/create_application_dto.dart';
import '../models/create_application/create_application_payload_dto.dart';

abstract class CreateApplicationRepository extends Repository<void> {
  factory CreateApplicationRepository(ApplicationsApi api) =>
      _CreateApplicationRepository(api);

  Future<String> createApplication({
    required String description,
    required CreateApplicationApplicationType type,
    required String? sentFromWarehouseId,
    required String? sentToWarehouseId,
    required String? linkedToApplicationId,
    required List<OskCreateApplicationProduct> items,
  });

  Future<String> updateApplication({
    required String id,
    required String description,
    required CreateApplicationApplicationType type,
    required String? sentFromWarehouseId,
    required String? sentToWarehouseId,
    required String? linkedToApplicationId,
    required List<OskCreateApplicationProduct> items,
  });
}

class _CreateApplicationRepository extends Repository<void>
    implements CreateApplicationRepository {
  final ApplicationsApi _api;

  _CreateApplicationRepository(this._api);

  @override
  Future<String> createApplication({
    required String description,
    required CreateApplicationApplicationType type,
    required String? sentFromWarehouseId,
    required String? sentToWarehouseId,
    required String? linkedToApplicationId,
    required List<OskCreateApplicationProduct> items,
  }) async {
    try {
      final data = CreateApplicationDto(
        applicationData: CreateApplicationDataDto(
          description: description,
          type: type.name,
          sentFromWarehouseId: sentFromWarehouseId,
          sentToWarehouseId: sentToWarehouseId,
          linkedToApplicationId: linkedToApplicationId,
        ),
        applicationPayload: CreateApplicationPayloadDto(
          items: items
              .map(
                (e) => ProductDto(
                  id: e.product.id,
                  itemName: e.product.name,
                  codes: e.product.codes.toList(),
                  itemType: e.product.type,
                  manufacturer: e.product.manufacturer,
                  model: e.product.model,
                  count: e.count,
                ),
              )
              .toList(),
        ),
      );

      final application = await _api.createApplication(
        data,
        const Uuid().v4(),
      );
      return application.id;
    } on Exception catch (e) {
      throw buildError(
        fallbackMessage:
            'Не удалось создать заявку. Пожалуйста, попробуйте позже',
        e: e,
      );
    }
  }

  @override
  Future<String> updateApplication({
    required String id,
    required String description,
    required CreateApplicationApplicationType type,
    required String? sentFromWarehouseId,
    required String? sentToWarehouseId,
    required String? linkedToApplicationId,
    required List<OskCreateApplicationProduct> items,
  }) async {
    try {
      final data = CreateApplicationDto(
        applicationData: CreateApplicationDataDto(
          description: description,
          type: type.name,
          sentFromWarehouseId: sentFromWarehouseId,
          sentToWarehouseId: sentToWarehouseId,
          linkedToApplicationId: linkedToApplicationId,
        ),
        applicationPayload: CreateApplicationPayloadDto(
          items: items
              .map(
                (e) => ProductDto(
                  id: e.product.id,
                  itemName: e.product.name,
                  codes: e.product.codes.toList(),
                  itemType: e.product.type,
                  manufacturer: e.product.manufacturer,
                  model: e.product.model,
                  count: e.count,
                ),
              )
              .toList(),
        ),
      );

      final application = await _api.updateApplication(
        data,
        id,
      );
      return application.id;
    } on Exception catch (e) {
      throw buildError(
        fallbackMessage:
            'Не удалось обновить,здать заявку. Пожалуйста, попробуйте позже',
        e: e,
      );
    }
  }
}
