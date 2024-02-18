import 'dart:async';

import 'package:flutter/foundation.dart';

import '../error/repository_localized_error.dart';
import 'repository.dart';

mixin RepositorySubscriber<T> {
  Repository<T> get repository;

  StreamSubscription<T>? _dataStreamSubscription;
  StreamSubscription<bool>? _loadingStreamSubscription;

  @mustCallSuper
  void start() {
    _dataStreamSubscription ??= repository.dataStream.listen(
      onData,
      // ignore: inference_failure_on_untyped_parameter
      onError: (error) => onRepositoryError(error as RepositoryLocalizedError),
      cancelOnError: false,
    );

    _loadingStreamSubscription ??= repository.loadingStream.listen(onLoading);
  }

  @protected
  void onData(T value);

  @protected
  void onLoading(bool loading);

  @protected
  void onRepositoryError(RepositoryLocalizedError error);

  @mustCallSuper
  void stop() {
    repository.stop();

    _dataStreamSubscription?.cancel();
    _dataStreamSubscription = null;

    _loadingStreamSubscription?.cancel();
    _loadingStreamSubscription = null;
  }
}
