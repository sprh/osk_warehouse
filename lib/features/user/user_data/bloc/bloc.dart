import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../../warehouse/models/warehouse.dart';
import '../../current_user_holder/current_user_holder.dart';
import '../../data/user_repository.dart';
import '../../models/user.dart';
import '../../models/user_access_types.dart';
import 'state.dart';

part 'events.dart';

abstract class UserDataBloc extends Bloc<UserDataPageEvent, UserDataState> {
  static UserDataBloc of(BuildContext context) => BlocProvider.of(context);

  factory UserDataBloc(
    AccountScopeNavigationManager navigationManager,
    UserRepository repository,
    String? username,
    CurrentUserHolder currentUserHolder,
  ) =>
      _UserDataBloc(
        navigationManager,
        repository,
        currentUserHolder,
        username: username,
      );
}

class _UserDataBloc extends Bloc<UserDataPageEvent, UserDataState>
    with RepositorySubscriber<(User?, List<Warehouse>)>
    implements UserDataBloc {
  final AccountScopeNavigationManager _navigationManager;
  final UserRepository _repository;
  final String? username;
  final CurrentUserHolder _currentUserHolder;

  _UserDataBloc(
    this._navigationManager,
    this._repository,
    this._currentUserHolder, {
    required this.username,
  }) : super(UserDataStateInitial()) {
    on<UserDataPageEvent>(_onEvent);
  }

  @override
  Repository<(User?, List<Warehouse>)> get repository => _repository;

  Future<void> _onEvent(
    UserDataPageEvent event,
    Emitter<UserDataState> emit,
  ) async {
    switch (event) {
      case UserDataPageEventInitialize():
        _repository.start();
        start();
        await _repository.refreshData(username);
      case _UserDataPageEventSetLoading():
        _maybeSetLoading(event.loading, emit);
      case _UserDataPageEventSetData():
        await _setData(event.user, event.warehouses, emit);
      case UserDataPageEventAddOrUpdateUser():
        _addOrUpdateUser(event);
    }
  }

  @override
  void onData((User?, List<Warehouse>) value) => add(
        _UserDataPageEventSetData(user: value.$1, warehouses: value.$2),
      );

  @override
  void onLoading(bool loading) => add(_UserDataPageEventSetLoading(loading));

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  void _maybeSetLoading(bool loading, Emitter<UserDataState> emit) {
    final state = this.state;
    switch (state) {
      case UserDataStateInitial():
        break;
      case UserDataStateUpdate():
        emit(
          UserDataStateUpdate(
            user: state.user,
            availableWarehouses: state.availableWarehouses,
            loading: loading,
            canEditData: state.canEditData,
          ),
        );
      case UserDataStateCreate():
        emit(
          UserDataStateCreate(
            availableWarehouses: state.availableWarehouses,
            loading: loading,
            canEditData: state.canEditData,
          ),
        );
    }
  }

  Future<void> _setData(
    User? user,
    List<Warehouse> warehouses,
    Emitter<UserDataState> emit,
  ) async {
    final currentUser = await _currentUserHolder.currentUser;

    if (user != null) {
      emit(
        UserDataStateUpdate(
          user: user,
          availableWarehouses: warehouses,
          canEditData: currentUser.canManagerUser,
        ),
      );
    } else {
      emit(
        UserDataStateCreate(
          availableWarehouses: warehouses,
          canEditData: currentUser.canManagerUser,
        ),
      );
    }
  }

  void _addOrUpdateUser(
    UserDataPageEventAddOrUpdateUser event,
  ) {
    try {
      if (username != null) {
        _repository.updateUser(
          username: username!,
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
          warehouses: event.warehouses.map((w) => w.id).toList(),
          isAdmin: event.accessTypes.contains(UserAccessTypes.admin),
          isReviewer: event.accessTypes.contains(UserAccessTypes.reviewer),
          isSuperuser: event.accessTypes.contains(UserAccessTypes.superuser),
          password: event.password,
        );
      } else {
        _repository.createUser(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
          warehouses: event.warehouses.map((w) => w.id).toList(),
          isAdmin: event.accessTypes.contains(UserAccessTypes.admin),
          isReviewer: event.accessTypes.contains(UserAccessTypes.reviewer),
          isSuperuser: event.accessTypes.contains(UserAccessTypes.superuser),
          password: event.password,
        );
      }
      _navigationManager.pop();
    } catch (_) {}
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
