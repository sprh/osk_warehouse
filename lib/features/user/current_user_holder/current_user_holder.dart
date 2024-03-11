import '../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../data/api/api.dart';
import '../models/user.dart';

class CurrentUserHolder {
  final CurrentUsernameHolder _currentUsernameHolder;
  final UserApi _userApi;

  CurrentUserHolder(this._currentUsernameHolder, this._userApi);

  User? _savedUser;

  Future<User> get currentUser async {
    final saved = _savedUser;
    final currentUsername = _currentUsernameHolder.currentUserUsername;

    if (currentUsername == null) {
      throw StateError(
        'Used CurrentUserHolder when currentUserUsername was null',
      );
    }

    if (saved != null && currentUsername == saved.username) {
      return saved;
    }

    final dto = await _userApi.getUser(
      currentUsername,
    );

    return User.fromDto(dto, true);
  }
}
