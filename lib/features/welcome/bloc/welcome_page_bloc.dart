import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/logic/navigation_manager.dart';

abstract class WelcomePageBloc extends Cubit<dynamic> {
  factory WelcomePageBloc(NavigationManager navigationManager) =>
      _WelcomePageBloc(navigationManager);

  void onLoginButtonTap();
}

class _WelcomePageBloc extends Cubit<dynamic> implements WelcomePageBloc {
  final NavigationManager _navigationManager;

  _WelcomePageBloc(this._navigationManager) : super(null);

  @override
  void onLoginButtonTap() => _navigationManager.openLogin();
}
