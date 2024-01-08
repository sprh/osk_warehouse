import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osk_warehouse/assets/assets_provider.dart';
import 'package:osk_warehouse/components/osk_scaffold.dart';
import 'package:osk_warehouse/features/initial_page/di.dart';
import 'package:osk_warehouse/features/initial_page/presentation/initial_page_view_model.dart';
import 'package:osk_warehouse/mvvm/feature_widget.dart';

class InitialPage extends FeatureView<InitialPageViewModel, void> {
  const InitialPage({super.key});

  @override
  FeatureViewBuilder get builder => (_, __) => _InitialPage();

  @override
  StateNotifierProvider<InitialPageViewModel, void> get viewModel =>
      InitialDi.viewModel;
}

class _InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return OskScaffold(
      body: SvgPicture.asset(
        AssetsProvider.splash,
        alignment: AlignmentDirectional.centerStart,
        fit: BoxFit.cover,
        width: mediaQuery.width,
      ),
    );
  }
}
