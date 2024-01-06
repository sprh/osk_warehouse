import 'dart:async';

import 'package:osk_warehouse/features/navigation/logic/navigation_manager.dart';
import 'package:osk_warehouse/mvvm/feature_view_model.dart';

abstract class InitialPageViewModel extends FeatureViewModel<void> {
  InitialPageViewModel() : super(null);
}

class InitialPageViewModelImpl extends InitialPageViewModel {
  final NavigationManager _navigationManager;

  InitialPageViewModelImpl({
    required NavigationManager navigationManager,
  }) : _navigationManager = navigationManager;

  @override
  Future<void> featureInit() async {
    // TODO(sktimokhina): try login & initialization logic

    Future.delayed(const Duration(seconds: 2), _navigationManager.openWelcome);
  }

  @override
  void featureDispose() {}
}
