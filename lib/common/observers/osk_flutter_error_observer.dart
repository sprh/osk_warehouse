import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../logger/tagged_logger.dart';

class FlutterErrorObserver {
  static final _logger = Logger(
    printer: TaggedLogger(tag: FlutterErrorObserver),
    level: Level.error,
  );

  static void setupErrorHandlers() {
    FlutterError.onError = _recordError;
    WidgetsBinding.instance.platformDispatcher.onError =
        _recordPlatformDispatcherError;

    _logger.i('Initialized');
  }

  static bool _recordPlatformDispatcherError(
    Object error,
    StackTrace stackTrace,
  ) {
    _logger.e(
      'Error from PlatformDispatcher',
      error: error,
      stackTrace: stackTrace,
    );
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    return true;
  }

  static void _recordError(FlutterErrorDetails details) {
    _logger.e(
      'Error from FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );

    FirebaseCrashlytics.instance.recordError(
      details.exception,
      details.stack,
    );
  }
}
