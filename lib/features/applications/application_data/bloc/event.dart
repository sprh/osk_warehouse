part of 'bloc.dart';

sealed class ApplicationDataEvent {}

class ApplicationDataEventInitialize implements ApplicationDataEvent {}

class _ApplicationDataEventOnData implements ApplicationDataEvent {
  final Application data;

  _ApplicationDataEventOnData(this.data);
}

class ApplicationDataEventOnItemTap implements ApplicationDataEvent {
  final String id;

  const ApplicationDataEventOnItemTap(this.id);
}

class ApplicationDataEventOnUserTap implements ApplicationDataEvent {
  final String username;

  const ApplicationDataEventOnUserTap(this.username);
}

class ApplicationDataEventOnActionTap implements ApplicationDataEvent {
  final ApplicationAction action;

  const ApplicationDataEventOnActionTap(this.action);
}

class _ApplicationDataEventSetLoading implements ApplicationDataEvent {
  final bool isLoading;

  const _ApplicationDataEventSetLoading(this.isLoading);
}
