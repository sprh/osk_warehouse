import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/error/repository_localized_error.dart';
import '../../../../common/interface/repository.dart';
import '../../../../common/interface/repository_subscriber.dart';
import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../data/repository/applications_list_repository.dart';
import '../../models/application/application.dart';
import '../../models/applications_list_state/applications_list_state.dart';

part 'event.dart';
part 'state.dart';

abstract class ApplicationsListBloc
    extends Bloc<ApplicationsListEvent, ApplicationsListState> {
  static ApplicationsListBloc of(BuildContext context) =>
      BlocProvider.of(context);

  factory ApplicationsListBloc(
    ApplicationsListRepository repository,
    AccountScopeNavigationManager navigationManager,
  ) =>
      _ApplicationsListBloc(repository, navigationManager);
}

class _ApplicationsListBloc
    extends Bloc<ApplicationsListEvent, ApplicationsListState>
    with RepositorySubscriber<ApplicationListRepositoryState>
    implements ApplicationsListBloc {
  final ApplicationsListRepository _repository;
  final AccountScopeNavigationManager _navigationManager;

  _ApplicationsListBloc(this._repository, this._navigationManager)
      : super(const ApplicationsListStateIdle()) {
    on<ApplicationsListEvent>(_onEvent);
  }

  @override
  Repository<ApplicationListRepositoryState> get repository => _repository;

  @override
  void onData(ApplicationListRepositoryState value) => add(
        _ApplicationListEventOnLoaded(value),
      );

  @override
  void onLoading(bool loading) {}

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(error.message);

  Future<void> _onEvent(
    ApplicationsListEvent event,
    Emitter<ApplicationsListState> emit,
  ) async {
    switch (event) {
      case ApplicationsListEventInitialize():
        _repository.start();
        start();
        await _repository.loadApplications();
      case _ApplicationListEventOnLoaded():
        emit(
          ApplicationsListStateData(
            event.data.applications,
            event.data.hasMore,
          ),
        );
      case ApplicationListEventOnLoadMore():
        await _repository.loadMore();
      case ApplicationListEventOnApplicationTap():
        _navigationManager.openApplicationData(event.applicationId);
    }
  }

  @override
  Future<void> close() {
    _repository.stop();
    stop();
    return super.close();
  }
}
