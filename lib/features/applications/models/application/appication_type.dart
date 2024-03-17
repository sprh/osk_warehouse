import '../../data/models/application/application_data_dto.dart';

enum ApplicationType {
  /// Отправка со склада на склад
  send,

  /// Приемка
  /// Может быть первичная, может быть со склада на склад
  recieve,

  /// Браковка
  defect,

  /// Использование
  use,

  /// Отмена заявки
  /// Не создается в UI создания заявки, доступно только из существующей заявки
  revert;

  static ApplicationType fromDto(ApplicationTypeDto dto) {
    switch (dto) {
      case ApplicationTypeDto.send:
        return send;
      case ApplicationTypeDto.recieve:
        return recieve;
      case ApplicationTypeDto.defect:
        return defect;
      case ApplicationTypeDto.use:
        return use;
      case ApplicationTypeDto.revert:
        return revert;
    }
  }
}
