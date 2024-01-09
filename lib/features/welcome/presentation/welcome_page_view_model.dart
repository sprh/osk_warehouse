import 'dart:async';

import '../../../mvvm/feature_view_model.dart';
import '../../navigation/logic/navigation_manager.dart';

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
