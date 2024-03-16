import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../components/products_list.dart';
import '../bloc/bloc.dart';

class SelectProductsPage extends StatefulWidget {
  const SelectProductsPage({super.key});

  @override
  State<SelectProductsPage> createState() => _SelectProductsPageState();
}

class _SelectProductsPageState extends State<SelectProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => SelectProductsBloc.of(context).add(
        SelectProductsEventInitialize(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SelectProductsBloc, SelectProductsState>(
        bloc: SelectProductsBloc.of(context),
        builder: (context, s) {
          final state = s;
          return OskScaffold.slivers(
            header: OskScaffoldHeader(
              leading: const OskServiceIcon.products(),
              title: 'Выберите товары',
              actions: const [
                OskCloseIconButton(),
                SizedBox(width: 8),
              ],
            ),
            slivers: [
              Builder(
                builder: (context) {
                  switch (state) {
                    case SelectProductsStateIdle():
                      return const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case SelectProductsStateData():
                      return SliverPadding(
                        padding: const EdgeInsets.only(top: 16),
                        sliver: ProductsList.selectable(
                          products: state.products,
                          onSelected: (id) =>
                              SelectProductsBloc.of(context).add(
                            SelectProductsEventOnSelect(id),
                          ),
                          selectedProducts: state.selectedProductIds,
                        ),
                      );
                  }
                },
              ),
            ],
            actions: [
              if (state is SelectProductsStateData)
                OskButton.main(
                  title: 'Выбрать',
                  subtitle: state.selectedProductIds.isEmpty
                      ? 'Выберите хотя бы один товар'
                      : null,
                  state: state.selectedProductIds.isEmpty
                      ? OskButtonState.disabled
                      : OskButtonState.enabled,
                  onTap: () => SelectProductsBloc.of(context).add(
                    SelectProductsEventDoneButtonTap(),
                  ),
                ),
            ],
          );
        },
      );
}
