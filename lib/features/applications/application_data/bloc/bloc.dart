import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/actions/actions_flex.dart';
import '../../../../common/components/button/osk_button.dart';
import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../data/repository/application_data_repository.dart';
import '../../data/repository/applications_list_repository.dart';
import '../../models/application/application.dart';
import '../../models/application/application_actions.dart';

part 'event.dart';
part 'state.dart';

abstract class ApplicationDataBloc
    extends Bloc<ApplicationDataEvent, ApplicationDataState> {
  static ApplicationDataBloc of(BuildContext context) =>
      BlocProvider.of(context);

  factory ApplicationDataBloc(
    AccountScopeNavigationManager navigationManager,
    ApplicationDataRepository repository,
    String applicationId,
    ApplicationsListRefresher applicationsListRefresher,
  ) = _ApplicatioDataBloc;
}

class _ApplicatioDataBloc
    extends Bloc<ApplicationDataEvent, ApplicationDataState>
    with RepositorySubscriber<Application>
    implements ApplicationDataBloc {
  final AccountScopeNavigationManager _navigationManager;
  final ApplicationDataRepository _repository;
  final String _applicationId;
  final ApplicationsListRefresher _applicationsListRefresher;

  _ApplicatioDataBloc(
    this._navigationManager,
    this._repository,
    this._applicationId,
    this._applicationsListRefresher,
  ) : super(ApplicationDataStateIdle()) {
    on<ApplicationDataEvent>(_onEvent);
  }

  @override
  Repository<Application> get repository => _repository;

  @override
  void onData(Application value) => add(_ApplicationDataEventOnData(value));

  @override
  void onLoading(bool loading) => add(_ApplicationDataEventSetLoading(loading));

  @override
  Future<void> onRepositoryError(RepositoryLocalizedError error) async {
    await _navigationManager.showSomethingWentWrontDialog(error.message);
    _navigationManager.pop();
  }

  Future<void> _onEvent(
    ApplicationDataEvent event,
    Emitter<ApplicationDataState> emit,
  ) async {
    switch (event) {
      case ApplicationDataEventInitialize():
        _repository.start();
        start();
        await _repository.loadApplication(_applicationId);
      case _ApplicationDataEventOnData():
        emit(ApplicationDataStateData(event.data));
      case ApplicationDataEventOnItemTap():
        _navigationManager.openProductData(event.id);
      case ApplicationDataEventOnUserTap():
        _navigationManager.openUserData(event.username);
      case ApplicationDataEventOnActionTap():
        if (event.action != ApplicationAction.edit) {
          _showAreYouSureDialog(
            () => _onActionTap(event.action, emit),
            _actionName(event.action),
          );
        } else {
          await _onActionTap(event.action, emit);
        }
      case _ApplicationDataEventSetLoading():
        _setLoading(event.isLoading, emit);
    }
  }

  void _setLoading(bool loading, Emitter<ApplicationDataState> emit) {
    final state = this.state;
    switch (state) {
      case ApplicationDataStateIdle():
        break;
      case ApplicationDataStateData():
        emit(state.copyWith(loading: loading));
    }
  }

  String _actionName(ApplicationAction action) {
    switch (action) {
      case ApplicationAction.reject:
        return 'отклонить';
      case ApplicationAction.approve:
        return 'подтвердить';
      case ApplicationAction.edit:
        return 'редактировать';
      case ApplicationAction.delete:
        return 'удалить';
    }
  }

  Future<void> _onActionTap(
    ApplicationAction action,
    Emitter<ApplicationDataState> emit,
  ) async {
    try {
      switch (action) {
        case ApplicationAction.reject:
          await _repository.reject(_applicationId);
          _applicationsListRefresher.refresh();
          _navigationManager.pop();
        case ApplicationAction.approve:
          await _repository.approve(_applicationId);
          _applicationsListRefresher.refresh();
          _navigationManager.pop();
        case ApplicationAction.edit:
          _navigationManager
            ..pop()
            ..openEditApplication(
              (state as ApplicationDataStateData).application,
            );
        case ApplicationAction.delete:
          await _repository.delete(_applicationId);
          _applicationsListRefresher.refresh();
          _navigationManager.pop();
      }
      // ignore: avoid_catching_errors
    } on RepositoryLocalizedError catch (error) {
      await _navigationManager.showSomethingWentWrontDialog(error.message);
    }
  }

  void _showAreYouSureDialog(
    VoidCallback onAcceptTap,
    String actionName,
  ) =>
      _navigationManager.showModalDialog(
        title: 'Вы уверены, что хотите $actionName заявку?',
        actions: OskActionsFlex(
          direction: Axis.vertical,
          widgets: [
            OskButton.main(
              title: 'Подтвердить',
              onTap: () {
                _navigationManager.popDialog();
                onAcceptTap();
              },
            ),
            OskButton.minor(
              title: 'Отмена',
              onTap: _navigationManager.popDialog,
            ),
          ],
        ),
      );
}
