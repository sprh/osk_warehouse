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
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: OskText.body(
                              text:
                                  'Складов пока нет. Нажмите на кнопку Добавить, чтобы создать',
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverList.separated(
                        itemCount: state.items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, index) {
                          final item = state.items[index];

                          return Center(
                            child: OskInfoSlot.dismissible(
                              title: item.name,
                              subtitle: item.address,
                              onTap: () => WarehouseListBloc.of(context).add(
                                WarehouseListEventOpenProductsList(
                                  warehouseId: item.id,
                                ),
                              ),
                              dismissibleKey: ValueKey(item.id),
                              onDelete: () {
                                WarehouseListBloc.of(context).add(
                                  WarehouseListEventDeleteWarehouse(item.id),
                                );
                                return Future.value(false);
                              },
                              onEdit: () {
                                WarehouseListBloc.of(context).add(
                                  WarehouseListEventEditWarehouse(item.id),
                                );
                                return Future.value(false);
                              },
                            ),
                          );
                        },
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
