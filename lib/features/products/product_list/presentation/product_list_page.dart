import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../../components/products_list.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ProductListBloc.of(context).add(ProductListEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductListBloc, ProductListState>(
        bloc: ProductListBloc.of(context),
        builder: (context, state) => OskScaffold.slivers(
          header: OskScaffoldHeader(
            leading: const OskServiceIcon.products(),
            title: 'Товары',
            actions: const [
              OskCloseIconButton(),
              SizedBox(width: 8),
            ],
          ),
          slivers: [
            Builder(
              builder: (context) {
                switch (state) {
                  case ProductListInitialState():
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case ProductListDataState():
                    if (state.products.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: OskText.body(
                              textAlign: TextAlign.center,
                              text:
                                  'Товаров пока нет. Нажмите на кнопку Добавить, чтобы создать',
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: ProductsList(
                        products: state.products,
                        onProductTap: (id) => ProductListBloc.of(context).add(
                          ProductListProductTapEvent(id),
                        ),
                        onDelete: (id) => ProductListBloc.of(context).add(
                          ProductListEventDeleteProduct(id),
                        ),
                      ),
                    );
                }
              },
            ),
          ],
          actions: [
            if (state is ProductListDataState && state.showCreateProductButton)
              OskButton.main(
                title: 'Добавить',
                onTap: () => ProductListBloc.of(context).add(
                  ProductListEventAddNewProduct(),
                ),
              ),
          ],
        ),
      );
}
