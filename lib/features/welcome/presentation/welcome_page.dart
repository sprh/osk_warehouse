import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osk_warehouse/assets/assets_provider.dart';
import 'package:osk_warehouse/components/osk_text.dart';
import 'package:osk_warehouse/features/welcome/presentation/welcome_page_view_model.dart';
import 'package:osk_warehouse/features/welcome/welcome_di.dart';
import 'package:osk_warehouse/l10n/utils/l10n_from_context.dart';
import 'package:osk_warehouse/mvvm/feature_widget.dart';
import 'package:riverpod/riverpod.dart';

class WelcomePage extends FeatureView<WelcomePageViewModel, void> {
  const WelcomePage({super.key});

  @override
  FeatureViewBuilder<WelcomePageViewModel, void> get builder =>
      (viewModel, _) => _WelcomePage(viewModel);

  @override
  StateNotifierProvider<WelcomePageViewModel, void> get viewModel =>
      WelcomeDi.viewModel;
}

class _WelcomePage extends StatelessWidget {
  final WelcomePageViewModel viewModel;

  const _WelcomePage(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strings = context.strings;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 4,
            child: SvgPicture.asset(
              AssetsProvider.welcomeHeader,
              fit: BoxFit.cover,
              alignment: AlignmentDirectional.centerStart,
              width: size.width,
            ),
          ),
          const SizedBox(height: 24),
          Flexible(
            flex: 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OskText.header(
                  text: strings.oskCompanyName,
                  fontWeight: OskfontWeight.bold,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
