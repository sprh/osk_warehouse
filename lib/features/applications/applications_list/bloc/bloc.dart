import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../../data/repository/applications_list_repository.dart';

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
    implements ApplicationsListBloc {
  final ApplicationsListRepository repository;
  final AccountScopeNavigationManager navigationManager;

  _ApplicationsListBloc(this.repository, this.navigationManager)
      : super(const ApplicationsListStateIdle()) {
    on<ApplicationsListEvent>(_onEvent);
  }

  Future<void> _onEvent(
    ApplicationsListEvent event,
    Emitter<ApplicationsListState> emit,
  ) async {
    switch (event) {
      case ApplicationsListEventInitialize():
        await repository.loadApplications();
    }
  }
}
