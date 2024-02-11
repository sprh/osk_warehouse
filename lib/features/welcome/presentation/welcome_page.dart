import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/button/osk_button.dart';
import '../../../common/components/osk_image.dart';
import '../../../common/components/scaffold/osk_scaffold.dart';
import '../../../common/components/text/osk_text.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../bloc/welcome_page_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strings = context.strings;

    return OskScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          OskImage.welcomeHeader(
            alignment: AlignmentDirectional.centerStart,
            width: size.width,
          ),
          const SizedBox(height: 24),
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
              colorType: OskTextColorType.minor,
            ),
          ),
        ],
      ),
      actions: [
        _WelcomePageLoginAction(),
      ],
    );
  }
}

class _WelcomePageLoginAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: OskButton.main(
          title: context.strings.welcomeButtonTitle,
          onTap: BlocProvider.of<WelcomePageBloc>(context).onLoginButtonTap,
        ),
      );
}
