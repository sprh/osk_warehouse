import '../../data/models/application/application_data_dto.dart';

enum ApplicationStatus {
  pending,
  success,
  rejected,
  deleted;

  static ApplicationStatus fromDto(ApplicationStatusDto dto) {
    switch (dto) {
      case ApplicationStatusDto.pending:
        return ApplicationStatus.pending;
      case ApplicationStatusDto.success:
        return ApplicationStatus.success;
      case ApplicationStatusDto.rejected:
        return ApplicationStatus.rejected;
      case ApplicationStatusDto.deleted:
        return ApplicationStatus.deleted;
    }
  }
}
