import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../components/button/osk_close_icon_button.dart';
import '../../../../components/dropdown/components/osk_dropdown_menu_item.dart';
import '../../../../components/dropdown/osk_dropdown_menu.dart';
import '../../../../components/icon/osk_service_icons.dart';
import '../../../../components/osk_line_divider.dart';
import '../../../../components/scaffold/osk_scaffold.dart';
import '../../../../components/tap/osk_tap_animation.dart';
import '../../../../components/text/osk_text.dart';
import '../../../worker/models/worker.dart';
import '../../models/request.dart';

class RequestsListPage extends StatelessWidget {
  static final requests = [
    for (int i = 1; i < 10; ++i)
      Request(
        date: '12 мая',
        id: i.toString(),
        status: RequestStatus
            .values[Random().nextInt(RequestStatus.values.length - 1)],
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
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [_RequestItem()],
          ),
        ),
      );
}

class _RequestItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return OskTapAnimationBuilder(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.5),
              blurRadius: 8,
            ),
          ],
          color: Colors.white,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width / 10 * 9,
            maxWidth: size.width / 10 * 9,
            minHeight: size.height / 12,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                OskText.body(
                  text: 'Заявка #1',
                  fontWeight: OskfontWeight.bold,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: SizedBox.square(dimension: 8),
                    ),
                    const SizedBox(width: 4),
                    OskText.caption(text: 'Отменена'),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: OskLineDivider(withMargin: false),
                ),
                OskText.body(text: 'Миша Хромин'),
                const SizedBox(height: 8),
                OskText.body(
                  text:
                      'Описаниепоадвповдапоадвпоадпоаплвадповдапдвап',
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
