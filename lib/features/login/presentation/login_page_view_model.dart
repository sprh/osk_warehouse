import 'dart:async';

import 'package:osk_warehouse/mvvm/feature_view_model.dart';

abstract class LoginPageViewModel extends FeatureViewModel<void> {
  LoginPageViewModel() : super(null);
}

class LoginPageViewModelImpl extends LoginPageViewModel {
  LoginPageViewModelImpl();

  @override
  FutureOr<void> featureInit() {}

  @override
  FutureOr<void> featureDispose() {}
}
