import '../../features/applications/models/application/appication_type.dart';

class ApplicationDataMapper {
  static String getApplicationTypeAsString(ApplicationType type) {
    switch (type) {
      case ApplicationType.send:
        return 'Отправка';
      case ApplicationType.recieve:
        return 'Приемка';
      case ApplicationType.defect:
        return 'Браковка';
      case ApplicationType.use:
        return 'Использование';
      case ApplicationType.revert:
        return 'Отмена заявки';
    }
  }

  static String? getApplicationToWarehouseTitleByType(ApplicationType type) {
    switch (type) {
      case ApplicationType.send:
        return 'На склад';
      case ApplicationType.recieve:
        return 'На склад';
      case ApplicationType.defect:
        return null;
      case ApplicationType.use:
        return null;
      case ApplicationType.revert:
        return 'На склад';
    }
  }

  static String getApplicationFromWarehouseTitleByType(ApplicationType type) {
    switch (type) {
      case ApplicationType.send:
        return 'Со склада';
      case ApplicationType.recieve:
        return 'Со склада';
      case ApplicationType.defect:
        return 'На складе';
      case ApplicationType.use:
        return 'На складе';
      case ApplicationType.revert:
        return 'Со склада';
    }
  }
}
