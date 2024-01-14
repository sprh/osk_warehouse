import 'package:flutter/material.dart';
import 'package:riverpod/src/state_notifier_provider.dart';

import '../../../components/osk_action_block.dart';
import '../../../components/osk_icon_button.dart';
import '../../../components/osk_icons.dart';
import '../../../components/osk_scaffold.dart';
import '../../../components/osk_service_icons.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../../../mvvm/feature_widget.dart';
import '../main_page_di.dart';
import 'components/main_page_header.dart';
import 'main_page_view_model.dart';

class MainPage extends FeatureView<MainPageViewModel, void> {
  const MainPage({super.key});

  @override
  FeatureViewBuilder<MainPageViewModel, void> get builder =>
      (viewModel, _) => _MainPage(viewModel);

  @override
  StateNotifierProvider<MainPageViewModel, void> get viewModel =>
      MainPageDi.viewModel;
}

class _MainPage extends StatelessWidget {
  final MainPageViewModel viewModel;

  const _MainPage(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return OskScaffold.slivers(
      appBar: SliverAppBar(
        pinned: true,
        primary: true,
        actions: [
          OskIconButton(
            icon: OskIcon.notification(),
            onTap: () {}, // TODO
          ),
          SizedBox(width: 16),
          OskIconButton(
            icon: OskIcon.setting(),
            onTap: () {}, // TODO
          ),
          SizedBox(width: 16),
        ],
      ),
      slivers: [
        SliverToBoxAdapter(child: MainPageHeader()),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverGrid.count(
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            crossAxisCount: 2,
            children: [
              OskActionBlock(
                title: strings.createRequest,
                icon: OskServiceIcon.createRequest(),
                onTap: () {},
                notificationsCount: 9,
              ),
              OskActionBlock(
                title: strings.requests,
                icon: OskServiceIcon.request(),
                onTap: () {},
              ),
              OskActionBlock(
                title: strings.warehouses,
                icon: OskServiceIcon.warehouse(),
                onTap: () {},
              ),
              OskActionBlock(
                title: strings.workers,
                icon: OskServiceIcon.worker(),
                onTap: () {},
              ),
              OskActionBlock(
                title: strings.reports,
                icon: OskServiceIcon.report(),
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
