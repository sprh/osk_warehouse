import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:osk_warehouse/features/products/data/api/api.dart';
import 'package:osk_warehouse/features/products/data/api/models/product_dto.dart';
import 'package:osk_warehouse/features/products/data/api/models/product_list_dto.dart';
import 'package:osk_warehouse/features/products/data/product_list_repository.dart';
import 'package:osk_warehouse/features/products/models/product.dart';

import 'products_test.mocks.dart';

@GenerateMocks([ProductApi])
void main() {
  late MockProductApi mockProductApi;
  late ProductListRepository productListRepository;

  setUp(() {
    mockProductApi = MockProductApi();
    productListRepository = ProductListRepository(mockProductApi);
  });

  group('ProductListRepository Tests', () {
    test('refreshProductList emits products', () async {
      final dummyProducts = [
        ProductDto(
          id: '1',
          itemName: 'Product 1',
          itemType: ProductType.other.name,
          manufacturer: '',
          model: '',
          description: '',
          codes: <String>[],
        ),
        ProductDto(
          id: '2',
          itemName: 'Product 2',
          itemType: ProductType.other.name,
          manufacturer: '',
          model: '',
          description: '',
          codes: <String>[],
        ),
      ];

      expect(productListRepository.loading, isFalse);

      when(mockProductApi.getProductList()).thenAnswer(
        (_) async {
          await Future<Object?>.delayed(const Duration(seconds: 2));
          return ProductListDto(items: dummyProducts);
        },
      );

      final mappedItems = dummyProducts.map(Product.fromDto).toList();

      await productListRepository.refreshProductList(warehouseId: null);

      verify(mockProductApi.getProductList()).called(1);

      expect(
        productListRepository.lastValue?.length,
        equals(mappedItems.length),
      );
      expect(
        productListRepository.lastValue?.map((e) => e.id).toList(),
        equals(mappedItems.map((e) => e.id).toList()),
      );

      expect(productListRepository.loading, isFalse);
    });
  });
}
