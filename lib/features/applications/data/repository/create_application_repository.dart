import 'package:uuid/uuid.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../products/data/api/models/product_dto.dart';
import '../../models/osk_appication_type.dart';
import '../../models/osk_create_application_product.dart';
import '../api/api.dart';
import '../models/create_application/create_application_data_dto.dart';
import '../models/create_application/create_application_dto.dart';
import '../models/create_application/create_application_payload_dto.dart';

abstract class CreateApplicationRepository extends Repository<void> {
  factory CreateApplicationRepository(ApplicationsApi api) =>
      _CreateApplicationRepository(api);

  Future<void> createApplication({
    required String description,
    required OskApplicationType type,
    required String sentFromWarehouseId,
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
  Future<void> createApplication({
    required String description,
    required OskApplicationType type,
    required String sentFromWarehouseId,
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
                  itemType: e.product.type.name,
                  manufacturer: e.product.manufacturer,
                  model: e.product.model,
                  count: e.count,
                ),
              )
              .toList(),
        ),
      );

      await _api.createApplication(
        data,
        const Uuid().v4(),
      );
    } on Exception catch (_) {
      throw RepositoryLocalizedError(
        message: 'Не удалось создать заявку. Пожалуйста, попробуйте позже',
      );
    }
  }
}
