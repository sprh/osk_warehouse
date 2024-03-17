part of 'bloc.dart';

sealed class ApplicationsListState {}

class ApplicationsListStateIdle implements ApplicationsListState {
  const ApplicationsListStateIdle();
}

class ApplicationsListStateData implements ApplicationsListState {
  final List<Application> applications;
  final bool hasMore;

  const ApplicationsListStateData(this.applications, this.hasMore);
}
