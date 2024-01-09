import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../../components/osk_button.dart';
import '../../../components/osk_image.dart';
import '../../../components/osk_scaffold.dart';
import '../../../components/osk_text.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../../../mvvm/feature_widget.dart';
import '../welcome_di.dart';
import 'welcome_page_view_model.dart';

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

    return OskScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          OskImage.welcomeHeader(
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.centerStart,
            width: size.width,
          ),
          const SizedBox(height: 24),
          OskText.header(
            text: strings.oskCompanyName,
            fontWeight: OskfontWeight.bold,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * 2 / 3),
            child: OskText.caption(
              text: strings.welcomeInfoSubtitle,
              fontWeight: OskfontWeight.bold,
              textAlign: TextAlign.center,
              colorType: OskTextColorType.minor,
            ),
          ),
          SizedBox(height: 16),
          OskButton.main(
            title: strings.welcomeButtonTitle,
            sizeProportion: 2 / 3,
            onTap: viewModel.onLoginButtonTap,
          ),
          Spacer(),
          OskText.caption(
            text: strings.welcomeAppVersion,
            colorType: OskTextColorType.minor,
          ),
          SizedBox(height: safeArea.bottom + 4),
        ],
      ),
    );
  }
}
