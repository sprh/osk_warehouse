import 'package:flutter/material.dart';

import '../../../../components/button/osk_button.dart';
import '../../../../components/button/osk_close_icon_button.dart';
import '../../../../components/icon/osk_service_icons.dart';
import '../../../../components/scaffold/osk_scaffold.dart';
import '../../components/products_list.dart';
import '../../models/product.dart';

class ProductsListPage extends StatelessWidget {
  final String? warehouseId;

  static final products = [
    for (int i = 0; i < 10; ++i)
      Product(description: i.toString(), name: i.toString(), id: i.toString()),
  ];

  const ProductsListPage({
    required this.warehouseId,
    super.key,
  });

  @override
  Widget build(BuildContext context) => OskScaffold(
        header: const OskScaffoldHeader(
          leading: OskServiceIcon.products(),
          title: 'Продукты',
          actions: [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ProductsList(
            products: products,
            onProductTap: (id) {}, // TODO:
          ),
        ),
        actions: [
          OskButton.main(
            title: 'Добавить',
            onTap: () {}, // TODO:
          ),
        ],
      );
}
