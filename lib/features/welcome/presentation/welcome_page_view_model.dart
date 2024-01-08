import 'dart:async';

import 'package:osk_warehouse/features/navigation/logic/navigation_manager.dart';
import 'package:osk_warehouse/mvvm/feature_view_model.dart';

abstract class WelcomePageViewModel extends FeatureViewModel<void> {
  WelcomePageViewModel() : super(null);

  void onLoginButtonTap();
}

class WelcomePageViewModelImpl extends WelcomePageViewModel {
  final NavigationManager _navigationManager;

  WelcomePageViewModelImpl({
    required NavigationManager navigationManager,
  }) : _navigationManager = navigationManager;

  @override
  FutureOr<void> featureInit() {}

  @override
  FutureOr<void> featureDispose() {}

  @override
  void onLoginButtonTap() => _navigationManager.openLogin();
}
