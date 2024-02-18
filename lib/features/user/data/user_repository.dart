import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../../warehouse/data/repository.dart';
import '../../warehouse/models/warehouse.dart';
import '../models/user.dart';
import 'api/api.dart';
import 'api/models/user_dto.dart';

abstract class UserRepository extends Repository<(User?, List<Warehouse>)> {
  factory UserRepository(
    UserApi api,
    WarehouseListGetter warehouseListGetter,
    CurrentUsernameHolder currentUsernameHolder,
  ) =>
      _UserRepository(api, warehouseListGetter, currentUsernameHolder);

  Future<void> refreshData(String? userId);

  // Future<User> getUser(String id);

  // Future<void> createUser(String name, String address);

  // Future<void> updateUser(String name, String address, String id);

  // Future<void> deleteUser(String id);
}

class _UserRepository extends Repository<(User?, List<Warehouse>)>
    implements UserRepository {
  final UserApi _api;
  final WarehouseListGetter _warehouseListGetter;
  final CurrentUsernameHolder _currentUsernameHolder;

  _UserRepository(
    this._api,
    this._warehouseListGetter,
    this._currentUsernameHolder,
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
}
