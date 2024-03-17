import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../../models/application/application.dart';
import '../api/api.dart';

abstract class ApplicationDataRepository extends Repository<Application> {
  factory ApplicationDataRepository(
    ApplicationsApi api,
    CurrentUsernameHolder currentUsernameHolder,
  ) = _ApplicationDataRepository;

  Future<void> loadApplication(String id);

  Future<void> reject(String id);

  Future<void> approve(String id);

  Future<void> delete(String id);
}

class _ApplicationDataRepository extends Repository<Application>
    implements ApplicationDataRepository {
  final ApplicationsApi _api;
  final CurrentUsernameHolder _currentUsernameHolder;

  _ApplicationDataRepository(this._api, this._currentUsernameHolder);

  @override
  Future<void> loadApplication(String id) async {
    setLoading();
    try {
      final data = await _api.getApplication(id);
      emit(
        Application.fromDto(
          data,
          (username) => _currentUsernameHolder.currentUserUsername == username,
        ),
      );
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(message: 'Не удалось загрузить заявку'),
      );
    }
  }

  @override
  Future<void> approve(String id) async {
    try {
      setLoading();
      await _api.approve(id);
    } on Exception catch (_) {
      setLoading(false);
      throw RepositoryLocalizedError(message: 'Не удалось подтвердить заявку');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      setLoading();
      await _api.delete(id);
    } on Exception catch (_) {
      setLoading(false);
      throw RepositoryLocalizedError(
        message: 'Не удалось удалить заявку',
      );
    }
  }

  @override
  Future<void> reject(String id) async {
    try {
      setLoading();
      await _api.reject(id);
    } on Exception catch (_) {
      setLoading(false);
      throw RepositoryLocalizedError(
        message: 'Не удалось отклонить заявку',
      );
    }
  }
}
