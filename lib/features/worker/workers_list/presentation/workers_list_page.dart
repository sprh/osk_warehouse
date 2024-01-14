import 'package:flutter/material.dart';

import '../../../../components/button/osk_button.dart';
import '../../../../components/button/osk_close_icon_button.dart';
import '../../../../components/icon/osk_service_icons.dart';
import '../../../../components/osk_info_slot/osk_info_slot.dart';
import '../../../../components/scaffold/osk_scaffold.dart';

class WorkersListPage extends StatelessWidget {
  static final workers = [
    for (int i = 0; i < 10; ++i) i.toString(),
  ];

  const WorkersListPage({super.key});

  @override
  Widget build(BuildContext context) => OskScaffold(
        header: OskScaffoldHeader(
          leading: OskServiceIcon.worker(),
          title: 'Сотрудники',
          actions: [
            OskCloseIconButton(onClose: () {}),
            SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Column(
            children: workers
                .expand(
                  (w) => [
                    OskInfoSlot(
                      title: w,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )
                .toList(),
          ),
        ),
        actions: [
          OskButton.main(
            title: 'Добавить',
            onTap: () {},
          ),
        ],
      );
}
