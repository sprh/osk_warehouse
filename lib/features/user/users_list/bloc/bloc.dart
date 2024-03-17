import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/actions/actions_flex.dart';
import '../../../../common/components/button/osk_button.dart';
import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../current_user_holder/current_user_holder.dart';
import '../../data/user_list_repository.dart';
import '../../models/user.dart';
import 'state.dart';

part 'event.dart';

abstract class UserListBloc extends Bloc<UserListEvent, UserListState> {
  static UserListBloc of(BuildContext context) => BlocProvider.of(context);

  factory UserListBloc(
    AccountScopeNavigationManager navigationManager,
    UserListRepository repository,
    CurrentUserHolder currentUserHolder,
  ) =>
      _UserListBloc(
        navigationManager,
        repository,
        currentUserHolder,
      );
}

class _UserListBloc extends Bloc<UserListEvent, UserListState>
    with RepositorySubscriber<List<User>>
    implements UserListBloc {
  final AccountScopeNavigationManager _navigationManager;
  final UserListRepository _repository;
  final CurrentUserHolder _currentUserHolder;

  _UserListBloc(
    this._navigationManager,
    this._repository,
    this._currentUserHolder,
  ) : super(UserListInitialState()) {
    on<UserListEvent>(_onEvent);
  }

  @override
  Repository<List<User>> get repository => _repository;

  Future<void> _onEvent(
    UserListEvent event,
    Emitter<UserListState> emit,
  ) async {
    switch (event) {
      case UserListEventInitialize():
        _repository.start();
        start();
        await _repository.refreshUserList();
      case UserListEventAddNewUser():
        _navigationManager.openUserData();
      case UserListEventDeleteUser():
        await _navigationManager.showModalDialog(
          title: 'Вы уверены, что хотите удалить пользователя?',
          actions: OskActionsFlex(
            direction: Axis.vertical,
            widgets: [
              OskButton.main(
                title: 'Удалить',
                onTap: () {
                  _navigationManager.popDialog();
                  _repository.deleteUser(event.username);
                },
              ),
              OskButton.minor(
                title: 'Отмена',
                onTap: _navigationManager.popDialog,
              ),
            ],
          ),
        );
      case _UserListUpdateStateEvent():
        await _onUserListUpdate(event.users, event.loading, emit);
      case UserListUserTapEvent():
        _navigationManager.openUserData(event.username);
    }
  }

  @override
  void onData(List<User> value) => add(_UserListUpdateStateEvent(users: value));

  @override
  void onLoading(bool loading) => add(
        _UserListUpdateStateEvent(loading: loading),
      );

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  Future<void> _onUserListUpdate(
    List<User>? users,
    bool? loading,
    Emitter<UserListState> emit,
  ) async {
    final state = this.state;
    final currentUser = await _currentUserHolder.currentUser;

    if (state is UserListDataState) {
      emit(state.copyWith(loading: state.loading, users: users));
    } else if (users != null) {
      emit(
        UserListDataState(
          users,
          currentUser.canManagerUser,
          loading: loading ?? false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
