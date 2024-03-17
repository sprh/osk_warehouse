import '../../../products/models/product.dart';
import '../../data/models/application/application_dto.dart';
import 'application_actions.dart';
import 'application_data.dart';

class Application {
  final String id;
  final ApplicationData data;
  final List<Product> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ApplicationAction> actions;

  const Application({
    required this.id,
    required this.data,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.actions,
  });

  factory Application.fromDto(
    ApplicationDto dto,
    bool Function(String) isCurrentUser,
  ) =>
      Application(
        id: dto.id,
        data: ApplicationData.fromDto(dto.applicationData, isCurrentUser),
        products: dto.applicationPayload.items.map(Product.fromDto).toList(),
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
        actions: dto.actions?.map(ApplicationAction.fromDto).toList() ?? [],
      );
}
