import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../models/user.dart';
import 'api/api.dart';

// ignore: one_member_abstracts
abstract interface class UserListRefresher {
  void refreshData();
}

abstract class UserListRepository extends Repository<List<User>>
    implements UserListRefresher {
  factory UserListRepository(
    UserApi api,
    CurrentUsernameHolder currentUsernameHolder,
  ) =>
      _UserListRepository(api, currentUsernameHolder);

  Future<void> refreshUserList();

  Future<void> deleteUser(String username);
}

class _UserListRepository extends Repository<List<User>>
    implements UserListRepository, UserListRefresher {
  final UserApi _api;
  final CurrentUsernameHolder _currentUsernameHolder;

  _UserListRepository(
    this._api,
    this._currentUsernameHolder,
  );

  @override
  Future<void> refreshUserList() async {
    if (loading) {
      return;
    }

    await _refreshData();
  }

  @override
  void refreshData() => _refreshData();

  @override
  Future<void> deleteUser(String username) async {
    setLoading();

    try {
      await _api.deleteUser(username);
      await _refreshData();
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить список пользователей',
        ),
      );
    }
  }

  Future<void> _refreshData() async {
    setLoading();

    try {
      final data = await _api.getUserList();

      final users = data.items.map(
        (user) => User.fromDto(
          user,
          _currentUsernameHolder.currentUserUsername == user.username,
        ),
      );
      emit(users.toList());
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить список пользователей',
        ),
      );
    }
  }
}
