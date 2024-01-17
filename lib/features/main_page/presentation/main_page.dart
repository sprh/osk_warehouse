import 'package:flutter/material.dart';

import '../../../components/icon/osk_icon_button.dart';
import '../../../components/icon/osk_icons.dart';
import '../../../components/icon/osk_service_icons.dart';
import '../../../components/osk_action_block.dart';
import '../../../components/scaffold/osk_scaffold.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../bloc/main_page_bloc.dart';
import '../bloc/main_page_event.dart';
import 'components/main_page_header.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return OskScaffold.slivers(
      appBar: SliverAppBar(
        pinned: true,
        actions: [
          OskIconButton(
            icon: const OskIcon.notification(),
            onTap: () {}, // TODO
          ),
          const SizedBox(width: 16),
          OskIconButton(
            icon: const OskIcon.setting(),
            onTap: () {}, // TODO
          ),
          const SizedBox(width: 16),
        ],
      ),
      slivers: [
        const SliverToBoxAdapter(child: MainPageHeader()),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid.count(
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            crossAxisCount: 2,
            children: [
              OskActionBlock(
                title: strings.createRequest,
                icon: const OskServiceIcon.createRequest(),
                onTap: () {},
                notificationsCount: 9,
              ),
              OskActionBlock(
                title: strings.requests,
                icon: const OskServiceIcon.request(),
                onTap: () {},
              ),
              OskActionBlock(
                title: strings.warehouses,
                icon: const OskServiceIcon.warehouse(),
                onTap: () => MainPageBloc.of(context).add(
                  MainPageEventOpenWarehouseList(),
                ),
              ),
              OskActionBlock(
                title: strings.workers,
                icon: const OskServiceIcon.worker(),
                onTap: () => MainPageBloc.of(context).add(
                  MainPageEventOpenWorkersList(),
                ),
              ),
              OskActionBlock(
                title: strings.reports,
                icon: const OskServiceIcon.report(),
                onTap: () {},
              ),
              OskActionBlock(
                title: strings.productCards,
                icon: const OskServiceIcon.products(),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
