import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osk_warehouse/assets/assets_provider.dart';
import 'package:osk_warehouse/components/osk_button.dart';
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
    final safeArea = MediaQuery.of(context).padding;
    final strings = context.strings;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AssetsProvider.welcomeHeader,
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.centerStart,
            width: size.width,
          ),
          const SizedBox(height: 40),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OskText.header(
                text: strings.oskCompanyName,
                fontWeight: OskfontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width * 2 / 3),
                child: OskText.caption(
                  text: strings.welcomeInfoSubtitle,
                  fontWeight: OskfontWeight.bold,
                  textAlign: TextAlign.center,
                  minorText: true,
                ),
              ),
              SizedBox(height: 16),
              OskButton.main(
                title: strings.welcomeButtonTitle,
                sizeProportion: 2 / 3,
                onTap: () {}, // TODO(sktimokhina)
              ),
            ],
          ),
          Spacer(),
          OskText.caption(text: strings.welcomeAppVersion, minorText: true),
          SizedBox(height: safeArea.bottom + 4),
        ],
      ),
    );
  }
}
