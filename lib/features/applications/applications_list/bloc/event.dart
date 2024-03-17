part of 'bloc.dart';

sealed class ApplicationsListEvent {}

class ApplicationsListEventInitialize implements ApplicationsListEvent {}

class _ApplicationListEventOnLoaded implements ApplicationsListEvent {
  final ApplicationListRepositoryState data;

  const _ApplicationListEventOnLoaded(this.data);
}

class ApplicationListEventOnLoadMore implements ApplicationsListEvent {}

class ApplicationListEventOnApplicationTap implements ApplicationsListEvent {
  final String applicationId;

  const ApplicationListEventOnApplicationTap(this.applicationId);
}
