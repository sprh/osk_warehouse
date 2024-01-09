import 'dart:async';

import '../../../mvvm/feature_view_model.dart';

abstract class MainPageViewModel extends FeatureViewModel<void> {
  MainPageViewModel() : super(null);
}

class MainPageViewModelImpl extends MainPageViewModel {
  MainPageViewModelImpl();

  @override
  FutureOr<void> featureInit() {}

  @override
  FutureOr<void> featureDispose() {}
}
