import 'package:flutter/material.dart';

import '../../../components/button/osk_button.dart';
import '../../../components/osk_image.dart';
import '../../../components/scaffold/osk_scaffold.dart';
import '../../../components/text/osk_text.dart';
import '../../../components/text/osk_text_field.dart';
import '../../../l10n/utils/l10n_from_context.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => focusNode.requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strings = context.strings;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: OskScaffold(
        actions: [
          const SizedBox(height: 16),
          OskTextField(
            hintText: strings.loginPageLoginTextFieldHint,
            label: strings.loginPageLoginTextFieldLabel,
            focusNode: focusNode,
            autocorrect: false,
            enableSuggestions: false,
          ),
          const SizedBox(height: 16),
          OskTextField(
            hintText: strings.loginPagePasswordTextFieldHint,
            label: strings.loginPagePasswordTextFieldLabel,
            showobscureTextIcon: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          const SizedBox(height: 16),
          OskButton.main(
            title: strings.loginPageButtonTitle,
            onTap: () {}, // TODO:,
            // onTap: widget.viewModel.onLoginButtonTap,
          ),
          const SizedBox(height: 16),
        ],
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: OskImage.loginPageHeader(
                  fit: BoxFit.cover,
                  alignment: AlignmentDirectional.centerStart,
                  width: size.width - 32,
                ),
              ),
            ),
            const SizedBox(height: 24),
            OskText.header(
              text: strings.oskCompanyName,
              fontWeight: OskfontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
