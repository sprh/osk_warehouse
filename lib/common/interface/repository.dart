import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../error/repository_localized_error.dart';
import '../utils/kotlin_utils.dart';

abstract class Repository<T> {
  Stream<T> get dataStream {
    assert(
      _dataStreamController != null,
      'Call start() before using repository stream',
    );

    final stream = _dataStreamController?.stream;

    if (stream != null) {
      return lastValue?.let(stream.startWith) ?? stream;
    }

    return const Stream.empty();
  }

  Stream<bool> get loadingStream {
    assert(
      _loadingStreamController != null,
      'Call start() before using repository stream',
    );

    return _loadingStreamController?.stream.startWith(loading) ??
        const Stream.empty();
  }

  /// previous emitted value
  @protected
  @visibleForTesting
  T? lastValue;

  @protected
  @visibleForTesting
  bool loading = false;

  StreamController<T>? _dataStreamController;

  StreamController<bool>? _loadingStreamController;

  @mustCallSuper
  FutureOr<void> start() {
    _dataStreamController ??= StreamController<T>.broadcast();
    _loadingStreamController ??= StreamController<bool>.broadcast();
  }

  @nonVirtual
  @protected
  void emit(T value) {
    lastValue = value;
    _dataStreamController?.add(value);

    loading = false;
    _loadingStreamController?.add(false);
  }

  @nonVirtual
  @protected
  void emitError(RepositoryLocalizedError value) {
    _dataStreamController?.addError(value);
    loading = false;
    _loadingStreamController?.add(false);
  }

  @nonVirtual
  @protected
  void setLoading([bool loading = true]) {
    this.loading = loading;
    _loadingStreamController?.add(loading);
  }

  @mustCallSuper
  FutureOr<void> stop() {
    lastValue = null;

    loading = false;

    _dataStreamController?.close();
    _dataStreamController = null;

    _loadingStreamController?.close();
    _loadingStreamController = null;
  }
}
