import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/button/osk_button.dart';
import '../../../../components/modal/modal_dialog_actions.dart';
import '../../../navigation/logic/navigation_manager.dart';
import 'workers_list_event.dart';

abstract class WorkersListBloc extends Bloc<WorkersListEvent, dynamic> {
  static WorkersListBloc of(BuildContext context) => BlocProvider.of(context);

  factory WorkersListBloc(NavigationManager navigationManager) =>
      _WorkersListBloc(navigationManager);
}

class _WorkersListBloc extends Bloc<WorkersListEvent, dynamic>
    implements WorkersListBloc {
  final NavigationManager _navigationManager;

  _WorkersListBloc(this._navigationManager) : super(null) {
    on<WorkersListEvent>(_onEvent);
  }

  void _onEvent(WorkersListEvent event, Emitter<dynamic> emit) {
    switch (event) {
      case WorkersListEventAddNewUser():
        _navigationManager.openNewWorker();
        break;
      case WorkersListEventDeleteUser():
        _navigationManager.showModalDialog(
          title: 'Вы уверены, что хотите удалить пользователя?',
          actions: ModalDialogActions(
            direction: Axis.vertical,
            widgets: [
              OskButton.main(
                title: 'Удалить',
                onTap: () {}, // TODO
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
