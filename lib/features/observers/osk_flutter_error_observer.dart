import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../logger/tagged_logger.dart';

class FlutterErrorObserver {
  static final _logger = Logger(
    printer: TaggedLogger(tag: FlutterErrorObserver),
    level: Level.error,
  );

  static void setupErrorHandlers() {
    FlutterError.onError = _recordFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        _recordPlatformDispatcherError;

    _logger.i('Initialized');
  }

  static void _recordFlutterError(FlutterErrorDetails error) => _logger.e(
        'Error from FlutterError',
        error: error.exception,
        stackTrace: error.stack,
      );

  static bool _recordPlatformDispatcherError(
    Object error,
    StackTrace stackTrace,
  ) {
    _logger.e(
      'Error from PlatformDispatcher',
      error: error,
      stackTrace: stackTrace,
    );
    return true;
  }
}
