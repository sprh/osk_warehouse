import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button/osk_button.dart';
import '../../../components/osk_image.dart';
import '../../../components/scaffold/osk_scaffold.dart';
import '../../../components/text/osk_text.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../../navigation/scope/navigation_scope.dart';
import '../bloc/welcome_page_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strings = context.strings;

    return BlocProvider(
      create: (context) => WelcomePageBloc(NavigationScope.of(context)),
      child: OskScaffold(
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
      ),
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
