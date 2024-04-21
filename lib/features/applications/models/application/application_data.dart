import '../../../../common/utils/kotlin_utils.dart';
import '../../../user/models/user.dart';
import '../../data/models/application/application_data_dto.dart';
import 'appication_type.dart';
import 'application_simple_warehouse.dart';
import 'application_status.dart';

class ApplicationData {
  final int serialNumber;
  final String description;
  final ApplicationType type;
  final ApplicationStatus status;
  final User createdBy;
  final User? finishedBy;
  final ApplicationSimpleWarehouse? sentFromWarehouse;
  final ApplicationSimpleWarehouse? sentToWarehouse;
  final String? linkedToApplicationId;

  const ApplicationData({
    required this.serialNumber,
    required this.description,
    required this.type,
    required this.status,
    required this.createdBy,
    required this.finishedBy,
    required this.sentFromWarehouse,
    required this.sentToWarehouse,
    required this.linkedToApplicationId,
  });

  factory ApplicationData.fromDto(
    ApplicationDataDto dto,
    bool Function(String username) isCurrentUser,
  ) =>
      ApplicationData(
        serialNumber: dto.serialNumber,
        description: dto.description,
        type: ApplicationType.fromDto(dto.type),
        status: ApplicationStatus.fromDto(dto.status),
        createdBy: User.fromDto(
          dto.createdBy,
          isCurrentUser(dto.createdBy.username),
        ),
        finishedBy: dto.finishedBy?.let(
          (user) => User.fromDto(
            user,
            isCurrentUser(user.username),
          ),
        ),
        sentFromWarehouse: dto.sentFromWarehouse?.let(
          ApplicationSimpleWarehouse.fromDto,
        ),
        sentToWarehouse: dto.sentToWarehouse?.let(
          ApplicationSimpleWarehouse.fromDto,
        ),
        linkedToApplicationId: dto.linkedToApplicationId,
      );
}
