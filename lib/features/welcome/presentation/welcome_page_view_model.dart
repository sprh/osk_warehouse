import 'dart:async';

import 'package:osk_warehouse/mvvm/feature_view_model.dart';

abstract class WelcomePageViewModel extends FeatureViewModel<void> {
  WelcomePageViewModel() : super(null);
}

class WelcomePageViewModelImpl extends WelcomePageViewModel {
  @override
  FutureOr<void> featureInit() {}

  @override
  FutureOr<void> featureDispose() {}
}
