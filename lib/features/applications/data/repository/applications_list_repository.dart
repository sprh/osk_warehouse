import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../core/authorization/bloc/authorization_data_bloc.dart';
import '../../models/application/application.dart';
import '../../models/applications_list_state/applications_list_state.dart';
import '../api/api.dart';

abstract class ApplicationsListRepository
    extends Repository<ApplicationListRepositoryState> {
  factory ApplicationsListRepository(
    ApplicationsApi api,
    CurrentUsernameHolder currentUsernameHolder,
  ) =>
      _ApplicationsListRepository(api, currentUsernameHolder);

  Future<void> loadApplications();

  Future<void> loadMore();
}

class _ApplicationsListRepository
    extends Repository<ApplicationListRepositoryState>
    implements ApplicationsListRepository {
  final ApplicationsApi _api;
  final CurrentUsernameHolder _currentUsernameHolder;

  String? cursor;

  _ApplicationsListRepository(
    this._api,
    this._currentUsernameHolder,
  );

  @override
  Future<void> loadApplications() async {
    cursor = null;

    final data = await _loadData(null);
    if (data == null) return;

    final items = data.$1;
    final hasMore = data.$2;

    emit(
      ApplicationListRepositoryState(
        applications: items,
        hasMore: hasMore,
      ),
    );
  }

  @override
  Future<void> loadMore() async {
    if (cursor == null) {
      return;
    }
    final data = await _loadData(cursor);
    if (data == null) return;

    final previousItems = lastValue?.applications ?? [];

    final items = data.$1;
    final hasMore = data.$2;

    emit(
      ApplicationListRepositoryState(
        applications: [...previousItems, ...items],
        hasMore: hasMore,
      ),
    );
  }

  Future<(List<Application> items, bool hasMore)?> _loadData(
    String? cursor,
  ) async {
    setLoading();
    try {
      final applications = await _api.getApplications(cursor);
      this.cursor = applications.cursor;
      return (
        applications.items
            .map(
              (item) => Application.fromDto(
                item,
                (id) => id == _currentUsernameHolder.currentUserUsername,
              ),
            )
            .toList(),
        cursor != null
      );
    } on Exception catch (_) {
      emitError(
        RepositoryLocalizedError(message: 'Не удалось загрузить заявки'),
      );
      return null;
    } finally {
      setLoading(false);
    }
  }
}
