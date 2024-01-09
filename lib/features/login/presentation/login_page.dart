import 'package:flutter/material.dart';
import 'package:riverpod/src/state_notifier_provider.dart';

import '../../../components/osk_button.dart';
import '../../../components/osk_image.dart';
import '../../../components/osk_scaffold.dart';
import '../../../components/osk_text.dart';
import '../../../components/osk_text_field.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../../../mvvm/feature_widget.dart';
import '../login_di.dart';
import 'login_page_view_model.dart';

class LoginPage extends FeatureView<LoginPageViewModel, void> {
  const LoginPage();

  @override
  FeatureViewBuilder<LoginPageViewModel, void> get builder =>
      (viewModel, state) => _LoginPage(viewModel);

  @override
  StateNotifierProvider<LoginPageViewModel, void> get viewModel =>
      LoginDi.viewModel;
}

class _LoginPage extends StatefulWidget {
  final LoginPageViewModel viewModel;

  const _LoginPage(this.viewModel);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  late final _loginTextFieldFocusNode = FocusNode();
  late final _passwordTextFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _loginTextFieldFocusNode.requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strings = context.strings;

    return GestureDetector(
      onTap: () {
        _loginTextFieldFocusNode.unfocus();
        _passwordTextFieldFocusNode.unfocus();
      },
      child: OskScaffold(
        floatingActions: [
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: OskTextField(
              hintText: strings.loginPageLoginTextFieldHint,
              label: strings.loginPageLoginTextFieldLabel,
              focusNode: _loginTextFieldFocusNode,
              autocorrect: false,
              enableSuggestions: false,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: OskTextField(
              hintText: strings.loginPagePasswordTextFieldHint,
              label: strings.loginPagePasswordTextFieldLabel,
              focusNode: _passwordTextFieldFocusNode,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
            ),
          ),
          const SizedBox(height: 16),
          OskButton.main(
            title: strings.loginPageButtonTitle,
            sizeProportion: 2 / 3,
            onTap: widget.viewModel.onLoginButtonTap,
          ),
          const SizedBox(height: 16),
        ],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
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
            Spacer(),
          ],
        ),
      ),
    );
  }
}
