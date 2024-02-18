import 'package:uuid/uuid.dart';

import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../../warehouse/data/repository.dart';
import '../../warehouse/models/warehouse.dart';
import '../models/user.dart';
import 'api/api.dart';
import 'api/models/create_user_dto.dart';
import 'api/models/update_user_dto.dart';
import 'api/models/user_dto.dart';
import 'user_list_repository.dart';

abstract class UserRepository extends Repository<(User?, List<Warehouse>)> {
  factory UserRepository(
    UserApi api,
    WarehouseListGetter warehouseListGetter,
    CurrentUsernameHolder currentUsernameHolder,
    UserListRefresher userListRefresher,
  ) =>
      _UserRepository(
        api,
        warehouseListGetter,
        currentUsernameHolder,
        userListRefresher,
      );

  Future<void> refreshData(String? userId);

  Future<void> createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required List<String> warehouses,
    required bool isAdmin,
    required bool isReviewer,
    required bool isSuperuser,
    required String password,
  });

  Future<void> updateUser({
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required List<String> warehouses,
    required bool isAdmin,
    required bool isReviewer,
    required bool isSuperuser,
    required String password,
  });
}

class _UserRepository extends Repository<(User?, List<Warehouse>)>
    implements UserRepository {
  final UserApi _api;
  final WarehouseListGetter _warehouseListGetter;
  final CurrentUsernameHolder _currentUsernameHolder;
  final UserListRefresher _userListRefresher;

  _UserRepository(
    this._api,
    this._warehouseListGetter,
    this._currentUsernameHolder,
    this._userListRefresher,
  );

  @override
  Future<void> refreshData(String? userId) async {
    try {
      if (userId == null) {
        final warehouses = await _warehouseListGetter.warehouseList;
        emit((null, warehouses));
      } else {
        final data = await Future.wait(
          [_api.getUser(userId), _warehouseListGetter.warehouseList],
        );
        final userDto = data[0] as UserDto;
        final user = User.fromDto(
          userDto,
          _currentUsernameHolder.currentUserUsername == userDto.username,
        );
        final warehouses = data[1] as List<Warehouse>;
        emit((user, warehouses));
      }
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить данные пользователя',
        ),
      );
    }
  }

  Future<UserDto> getUser(String id) => _api.getUser(id);

  @override
  Future<void> createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required List<String> warehouses,
    required bool isAdmin,
    required bool isReviewer,
    required bool isSuperuser,
    required String password,
  }) async {
    try {
      await _api.createUser(
        CreateUserDto(
          username: username,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          warehouses: warehouses,
          isAdmin: isAdmin,
          isReviewer: isReviewer,
          isSuperuser: isSuperuser,
          password: password,
        ),
        const Uuid().v4(),
      );
      _userListRefresher.refreshData();
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось создать пользователя',
        ),
      );
      rethrow;
    }
  }

  @override
  Future<void> updateUser({
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required List<String> warehouses,
    required bool isAdmin,
    required bool isReviewer,
    required bool isSuperuser,
    required String password,
  }) async {
    try {
      await _api.updateUser(
        UpdateUserDto(
          username: username,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          warehouses: warehouses,
          isAdmin: isAdmin,
          isReviewer: isReviewer,
          isSuperuser: isSuperuser,
          password: password.isEmpty ? null : password,
        ),
      );
      _userListRefresher.refreshData();
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось обновить пользователя',
        ),
      );
      rethrow;
    }
  }
}
