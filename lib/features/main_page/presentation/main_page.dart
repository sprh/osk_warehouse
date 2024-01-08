import 'package:flutter/material.dart';
import 'package:osk_warehouse/assets/assets_provider.dart';
import 'package:osk_warehouse/components/osk_action_block.dart';
import 'package:osk_warehouse/components/osk_scaffold.dart';
import 'package:osk_warehouse/features/main_page/main_page_di.dart';
import 'package:osk_warehouse/features/main_page/presentation/main_page_view_model.dart';
import 'package:osk_warehouse/l10n/utils/l10n_from_context.dart';
import 'package:osk_warehouse/mvvm/feature_widget.dart';
import 'package:riverpod/src/state_notifier_provider.dart';

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

    return OskScaffold(
      body: GridView.count(
        primary: false,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 8,
        mainAxisSpacing: 4,
        crossAxisCount: 2,
        children: [
          OskActionBlock(
            title: strings.createRequest,
            iconPath: AssetsProvider.createRequest,
            onTap: () {},
            notificationsCount: 9,
          ),
          OskActionBlock(
            title: strings.requests,
            iconPath: AssetsProvider.request,
            onTap: () {},
          ),
          OskActionBlock(
            title: strings.warehouses,
            iconPath: AssetsProvider.warehouse,
            onTap: () {},
          ),
          OskActionBlock(
            title: strings.workers,
            iconPath: AssetsProvider.worker,
            onTap: () {},
          ),
          OskActionBlock(
            title: strings.reports,
            iconPath: AssetsProvider.report,
            onTap: () {},
          ),
          OskActionBlock(
            title: strings.productCards,
            iconPath: AssetsProvider.products,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
