import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button/osk_button.dart';
import '../../../components/osk_image.dart';
import '../../../components/scaffold/osk_scaffold.dart';
import '../../../components/text/osk_text.dart';
import '../../../components/text/osk_text_field.dart';
import '../../../l10n/utils/l10n_from_context.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_events.dart';
import '../bloc/login_page_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  bool buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusScope.of(context).requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final strings = context.strings;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BlocBuilder<LoginBloc, LoginPageState>(
        bloc: LoginBloc.of(context),
        builder: (context, state) => OskScaffold(
          actionsShadow: true,
          actions: [
            const SizedBox(height: 16),
            OskTextField(
              hintText: strings.loginPageLoginTextFieldHint,
              label: strings.loginPageLoginTextFieldLabel,
              autocorrect: false,
              enableSuggestions: false,
              onChanged: (text) {
                username = text;
                _onTextChanged();
              },
            ),
            const SizedBox(height: 16),
            OskTextField(
              hintText: strings.loginPagePasswordTextFieldHint,
              label: strings.loginPagePasswordTextFieldLabel,
              showobscureTextIcon: true,
              autocorrect: false,
              enableSuggestions: false,
              onChanged: (text) {
                password = text;
                _onTextChanged();
              },
            ),
            const SizedBox(height: 16),
            OskButton.main(
              state: state.isLoading
                  ? OskButtonState.loading
                  : buttonEnabled
                      ? OskButtonState.enabled
                      : OskButtonState.disabled,
              title: strings.loginPageButtonTitle,
              onTap: () => LoginBloc.of(context).add(
                LoginEventButtonSignInTap(
                  username: username,
                  password: password,
                ),
              ),
            ),
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
      ),
    );
  }

  void _onTextChanged() => setState(
        () => buttonEnabled =
            password.trim().isNotEmpty && username.trim().isNotEmpty,
      );
}
