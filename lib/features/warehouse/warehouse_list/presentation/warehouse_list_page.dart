import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/button/osk_button.dart';
import '../../../../common/components/button/osk_close_icon_button.dart';
import '../../../../common/components/icon/osk_service_icons.dart';
import '../../../../common/components/info_slot/osk_info_slot.dart';
import '../../../../common/components/scaffold/osk_scaffold.dart';
import '../../../../common/components/text/osk_text.dart';
import '../bloc/warehouse_list_bloc.dart';
import '../bloc/warehouse_list_state.dart';

class WarehouseListPage extends StatefulWidget {
  const WarehouseListPage({super.key});

  @override
  State<WarehouseListPage> createState() => _WarehouseListPageState();
}

class _WarehouseListPageState extends State<WarehouseListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => WarehouseListBloc.of(context).add(WarehouseListEventInitialize()),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WarehouseListBloc, WarehouseListState>(
        bloc: WarehouseListBloc.of(context),
        builder: (context, state) => OskScaffold.slivers(
          header: OskScaffoldHeader(
            leading: const OskServiceIcon.warehouse(),
            title: 'Склады',
            actions: const [
              OskCloseIconButton(),
              SizedBox(width: 8),
            ],
          ),
          slivers: [
            Builder(
              builder: (context) {
                switch (state) {
                  case WarehouseListIdleState():
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case WarehouseListDataState():
                    if (state.items.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: OskText.body(text: 'Складов пока нет'),
                        ),
                      );
                    }

                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          children: state.items
                              .expand(
                                (w) => [
                                  OskInfoSlot.dismissible(
                                    title: w.name,
                                    subtitle: w.address,
                                    onTap: () =>
                                        WarehouseListBloc.of(context).add(
                                      WarehouseListEventOpenProductsList(
                                        warehouseId: w.id,
                                      ),
                                    ),
                                    dismissibleKey: ValueKey(w.id),
                                    onDelete: () {
                                      // TODO:
                                      return Future.value(false);
                                    },
                                    onEdit: () {
                                      // TODO:
                                      return Future.value(false);
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              )
                              .toList(),
                        ),
                      ),
                    );
                }
              },
            ),
          ],
          actions: [
            OskButton.main(
              title: 'Добавить',
              onTap: () => WarehouseListBloc.of(context).add(
                WarehouseListEventOnCreateWarehouseTap(),
              ),
            ),
          ],
        ),
      );
}
