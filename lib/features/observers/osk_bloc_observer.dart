import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../logger/tagged_logger.dart';

class OskBlocObserver extends BlocObserver {
  final _logger = Logger(
    printer: TaggedLogger(tag: OskBlocObserver),
    level: Level.info,
  );

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    _logger.i('${bloc.runtimeType} created');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    _logger.i('${bloc.runtimeType} recieve event ${event.runtimeType}');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    _logger.i(
      '''${bloc.runtimeType} change state. OldState: ${change.currentState}. New state: ${change.nextState}''',
    );
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.e(
      '${bloc.runtimeType} error!',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
