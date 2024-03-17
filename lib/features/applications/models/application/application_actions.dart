import '../../data/models/application/application_dto.dart';

enum ApplicationAction {
  reject,
  approve,
  edit,
  delete;

  static ApplicationAction fromDto(ApplicationActionDto dto) {
    switch (dto) {
      case ApplicationActionDto.reject:
        return ApplicationAction.reject;
      case ApplicationActionDto.approve:
        return ApplicationAction.approve;
      case ApplicationActionDto.edit:
        return ApplicationAction.edit;
      case ApplicationActionDto.delete:
        return ApplicationAction.delete;
    }
  }
}
