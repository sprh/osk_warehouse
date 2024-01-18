import 'package:flutter/material.dart';

import '../../../../components/button/osk_button.dart';
import '../../../../components/button/osk_close_icon_button.dart';
import '../../../../components/icon/osk_service_icons.dart';
import '../../../../components/info_slot/osk_info_slot.dart';
import '../../../../components/scaffold/osk_scaffold.dart';
import '../../models/warehouse.dart';
import '../bloc/warehouse_list_bloc.dart';
import '../bloc/warehouse_list_event.dart';

class WarehouseListPage extends StatelessWidget {
  static final warehouses = [
    for (int i = 0; i < 10; ++i)
      Warehouse(
        name: '$i warehouse',
        description: i.toString(),
        id: i.toString(),
      ),
  ];

  const WarehouseListPage({super.key});

  @override
  Widget build(BuildContext context) => OskScaffold(
        header: OskScaffoldHeader(
          leading: const OskServiceIcon.warehouse(),
          title: 'Склады',
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: warehouses
                .expand(
                  (w) => [
                    OskInfoSlot.dismissible(
                      title: w.name,
                      subtitle: w.description,
                      onTap: () => WarehouseListBloc.of(context).add(
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
        actions: [
          OskButton.main(
            title: 'Добавить',
            onTap: () => WarehouseListBloc.of(context).add(
              WarehouseListEventOnCreateWarehouseTap(),
            ),
          ),
        ],
      );
}
