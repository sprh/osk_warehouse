import 'dart:async';

import 'package:osk_warehouse/features/navigation/logic/navigation_manager.dart';
import 'package:osk_warehouse/mvvm/feature_view_model.dart';

abstract class LoginPageViewModel extends FeatureViewModel<void> {
  LoginPageViewModel() : super(null);

  void onLoginButtonTap();
}

class LoginPageViewModelImpl extends LoginPageViewModel {
  final NavigationManager _navigationManager;

  LoginPageViewModelImpl({
    required NavigationManager navigationManager,
  }) : this._navigationManager = navigationManager;

  @override
  FutureOr<void> featureInit() {}

  @override
  FutureOr<void> featureDispose() {}

  @override
  void onLoginButtonTap() => _navigationManager.openMain();
}
