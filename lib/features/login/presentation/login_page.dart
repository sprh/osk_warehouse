import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osk_warehouse/assets/assets_provider.dart';
import 'package:osk_warehouse/components/osk_button.dart';
import 'package:osk_warehouse/components/osk_scaffold.dart';
import 'package:osk_warehouse/components/osk_text.dart';
import 'package:osk_warehouse/components/osk_text_field.dart';
import 'package:osk_warehouse/features/login/login_di.dart';
import 'package:osk_warehouse/features/login/presentation/login_page_view_model.dart';
import 'package:osk_warehouse/l10n/utils/l10n_from_context.dart';
import 'package:osk_warehouse/mvvm/feature_widget.dart';
import 'package:riverpod/src/state_notifier_provider.dart';

class LoginPage extends FeatureView<LoginPageViewModel, void> {
  const LoginPage();

  @override
  FeatureViewBuilder<LoginPageViewModel, void> get builder =>
      (manager, state) => const _LoginPage();

  @override
  StateNotifierProvider<LoginPageViewModel, void> get viewModel =>
      LoginDi.viewModel;
}

class _LoginPage extends StatefulWidget {
  const _LoginPage();

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
            title: strings.welcomeButtonTitle,
            sizeProportion: 2 / 3,
            onTap: () {}, // TODO(sktimokhina)
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
                child: SvgPicture.asset(
                  AssetsProvider.loginPageHeader,
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
