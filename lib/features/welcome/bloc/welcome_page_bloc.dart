import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/logic/navigation_manager.dart';

abstract class WelcomePageBloc extends Cubit<dynamic> {
  factory WelcomePageBloc(NavigationManager NavigationManager) =>
      _WelcomePageBloc(NavigationManager);

  void onLoginButtonTap();
}

class _WelcomePageBloc extends Cubit<dynamic> implements WelcomePageBloc {
  final NavigationManager _NavigationManager;

  _WelcomePageBloc(this._NavigationManager) : super(null);

  @override
  void onLoginButtonTap() => _NavigationManager.openLogin();
}
