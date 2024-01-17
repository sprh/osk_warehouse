import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../navigation/logic/navigation_manager.dart';
import 'new_worker_events.dart';

abstract class NewWorkerBloc extends Bloc<NewWorkerPageEvent, dynamic> {
  static NewWorkerBloc of(BuildContext context) => BlocProvider.of(context);

  factory NewWorkerBloc(NavigationManager navigationManager) =>
      _NewWorkerBloc(navigationManager);
}

class _NewWorkerBloc extends Bloc<NewWorkerPageEvent, dynamic>
    implements NewWorkerBloc {
  final NavigationManager _navigationManager;

  _NewWorkerBloc(this._navigationManager) : super(null) {
    on<NewWorkerPageEvent>(_onEvent);
  }

  void _onEvent(NewWorkerPageEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case NewWorkerPageEventClose():
        _navigationManager.pop();
    }
  }
}
