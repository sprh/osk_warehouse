import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/actions/actions_flex.dart';
import '../../../../components/button/osk_button.dart';
import '../../../../core/navigation/manager/navigation_manager.dart';
import 'workers_list_event.dart';

abstract class WorkersListBloc extends Bloc<WorkersListEvent, dynamic> {
  static WorkersListBloc of(BuildContext context) => BlocProvider.of(context);

  factory WorkersListBloc(AccountScopeNavigationManager navigationManager) =>
      _WorkersListBloc(navigationManager);
}

class _WorkersListBloc extends Bloc<WorkersListEvent, dynamic>
    implements WorkersListBloc {
  final AccountScopeNavigationManager _navigationManager;

  _WorkersListBloc(this._navigationManager) : super(null) {
    on<WorkersListEvent>(_onEvent);
  }

  void _onEvent(WorkersListEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case WorkersListEventAddNewUser():
        _navigationManager.openNewWorker();
      case WorkersListEventDeleteUser():
        _navigationManager.showModalDialog(
          title: 'Вы уверены, что хотите удалить пользователя?',
          actions: OskActionsFlex(
            direction: Axis.vertical,
            widgets: [
              OskButton.main(
                title: 'Удалить',
                onTap: () {}, // TODO:
              ),
              OskButton.minor(
                title: 'Отмена',
                onTap: _navigationManager.pop,
              ),
            ],
          ),
        );
    }
  }
}
