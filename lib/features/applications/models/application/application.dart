import '../../../products/models/product.dart';
import '../../data/models/application/application_dto.dart';
import 'application_data.dart';

class Application {
  final ApplicationData data;
  final List<Product> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Application({
    required this.data,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Application.fromDto(
    ApplicationDto dto,
    bool Function(String) isCurrentUser,
  ) =>
      Application(
        data: ApplicationData.fromDto(dto.applicationData, isCurrentUser),
        products: dto.applicationPayload.items.map(Product.fromDto).toList(),
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt,
      );
}
