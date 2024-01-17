import 'package:flutter/material.dart';

import '../../../../components/button/osk_button.dart';
import '../../../../components/button/osk_close_icon_button.dart';
import '../../../../components/icon/osk_service_icons.dart';
import '../../../../components/osk_info_slot/osk_info_slot.dart';
import '../../../../components/scaffold/osk_scaffold.dart';
import '../../models/worker.dart';
import '../bloc/workers_list_bloc.dart';
import '../bloc/workers_list_event.dart';

class WorkersListPage extends StatelessWidget {
  // TODO: change state
  static final workers = [
    for (int i = 0; i < 10; ++i)
      Worker(
        name: i.toString(),
        id: i.toString(),
      ),
  ];

  const WorkersListPage({super.key});

  @override
  Widget build(BuildContext context) => OskScaffold(
        header: const OskScaffoldHeader(
          leading: OskServiceIcon.worker(),
          title: 'Сотрудники',
          actions: [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: workers
                .expand(
                  (w) => [
                    OskInfoSlot.dismissible(
                      title: w.id,
                      onTap: () {},
                      dismissibleKey: ValueKey(w.id),
                      onDelete: () {
                        WorkersListBloc.of(context).add(
                          WorkersListEventDeleteUser(),
                        );
                        return Future.value(false);
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                )
                .toList(),
          ),
        ),
        actions: const [_NewWorkerAction()],
      );
}

class _NewWorkerAction extends StatelessWidget {
  const _NewWorkerAction();

  @override
  Widget build(BuildContext context) => OskButton.main(
        title: 'Добавить',
        onTap: () => WorkersListBloc.of(context).add(
          WorkersListEventAddNewUser(),
        ),
      );
}
