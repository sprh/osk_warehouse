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
import 'search_icon_button.dart';

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
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          bloc: ProductListBloc.of(context),
          builder: (context, state) {
            final availableSearchData = state.availableSearchData;

            return OskScaffold.slivers(
              header: OskScaffoldHeader(
                leading: const OskServiceIcon.products(),
                title: 'Товары',
                actions: [
                  if (availableSearchData != null)
                    SearchIconButton(
                      onSearchTap: () => ProductListBloc.of(context).add(
                        ProductListEventOpenSearch(availableSearchData),
                      ),
                      hasActiveSearch: availableSearchData.hasActiveSearch,
                    ),
                  const SizedBox(width: 8),
                  const OskCloseIconButton(),
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
                                  text: state.availableSearchData
                                              ?.hasActiveSearch ??
                                          false
                                      ? 'Нет товаров, подходящих под поисковый запрос'
                                      : 'Товаров пока нет.',
                                ),
                              ),
                            ),
                          );
                        }
                        return SliverPadding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          sliver: ProductsList(
                            products: state.products,
                            onProductTap: (id) =>
                                ProductListBloc.of(context).add(
                              ProductListProductTapEvent(id),
                            ),
                            onDelete: (id) => state.showCreateProductButton
                                ? ProductListBloc.of(context).add(
                                    ProductListEventDeleteProduct(id),
                                  )
                                : null,
                          ),
                        );
                    }
                  },
                ),
              ],
              actions: [
                if (state is ProductListDataState &&
                    state.showCreateProductButton)
                  OskButton.main(
                    title: 'Добавить',
                    onTap: () => ProductListBloc.of(context).add(
                      ProductListEventAddNewProduct(),
                    ),
                  ),
              ],
            );
          },
        ),
      );
}
