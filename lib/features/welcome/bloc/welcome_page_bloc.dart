import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/manager/app_scope_navigation_manager.dart';

abstract class WelcomePageBloc extends Cubit<dynamic> {
  factory WelcomePageBloc(AppScopeNavigationManager navigationManager) =>
      _WelcomePageBloc(navigationManager);

  void onLoginButtonTap();
}

class _WelcomePageBloc extends Cubit<dynamic> implements WelcomePageBloc {
  final AppScopeNavigationManager _navigationManager;

  _WelcomePageBloc(this._navigationManager) : super(null);

  @override
  void onLoginButtonTap() => _navigationManager.openLogin();
}
