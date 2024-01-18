import 'package:flutter/material.dart';

import '../../../../components/button/osk_close_icon_button.dart';
import '../../../../components/dropdown/components/osk_dropdown_menu_item.dart';
import '../../../../components/dropdown/osk_dropdown_menu.dart';
import '../../../../components/icon/osk_service_icons.dart';
import '../../../../components/osk_request_info/osk_request_info.dart';
import '../../../../components/scaffold/osk_scaffold.dart';
import '../../../worker/models/worker.dart';
import '../../models/request.dart';

class RequestsListPage extends StatelessWidget {
  static final requests = [
    for (int i = 1; i < 10; ++i)
      Request(
        description: '123',
        id: i.toString(),
        status: RequestStatus.values[i % RequestStatus.values.length],
        worker: Worker(id: i.toString(), name: i.toString()),
      ),
  ];
  const RequestsListPage({super.key});

  @override
  Widget build(BuildContext context) => OskScaffold(
        header: OskScaffoldHeader.customTitle(
          leading: const OskServiceIcon.request(),
          titleWidget: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: OskDropDown<RequestStatus?>(
              items: [
                OskDropdownMenuItem(label: 'Все заявки', value: null),
                OskDropdownMenuItem(
                  label: 'В ожидании',
                  value: RequestStatus.waiting,
                ),
                OskDropdownMenuItem(
                  label: 'Принятые',
                  value: RequestStatus.accepted,
                ),
                OskDropdownMenuItem(
                  label: 'Отмененные',
                  value: RequestStatus.cancelled,
                ),
              ],
              label: 'Все заявки',
            ),
          ),
          actions: const [
            OskCloseIconButton(),
            SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Column(
            children: requests
                .expand(
                  (r) => [
                    OskRequestInfo(
                      request: r, onTap: () => {}, // TODO:
                    ),
                    const SizedBox(height: 8),
                  ],
                )
                .toList(),
          ),
        ),
      );
}
