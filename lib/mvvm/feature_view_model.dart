import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FeatureViewModel<T> extends StateNotifier<T> {
  @override
  T get state => super.state;

  FeatureViewModel(super.state);

  FutureOr<void> featureInit();

  FutureOr<void> featureDispose();
}
