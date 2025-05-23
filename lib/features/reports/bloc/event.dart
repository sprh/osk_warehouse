part of 'bloc.dart';

sealed class ReportsEvent {}

class ReportsEventInitialize implements ReportsEvent {}

class _ReportsEventOnData implements ReportsEvent {
  final ReportsResponse value;

  const _ReportsEventOnData(this.value);
}

class ReportsEventOpenCalendar implements ReportsEvent {}

class _RepositoryEventOnSelectedPeriodChanged implements ReportsEvent {
  final List<DateTime> selectedPeriod;

  const _RepositoryEventOnSelectedPeriodChanged({required this.selectedPeriod});
}

class ReportsEventShareFile implements ReportsEvent {}

class ReportsEventSaveFile implements ReportsEvent {}

class _ReportsEventOpenFile implements ReportsEvent {
  final String path;

  const _ReportsEventOpenFile(this.path);
}
