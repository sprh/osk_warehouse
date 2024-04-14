part of 'bloc.dart';

sealed class ReportsState {}

class ReportsStateNoSelectedPeriod implements ReportsState {}

class ReportsStateSelectedPeriod implements ReportsState {
  final String formattedPeriod;
  final ReportsResponse response;

  const ReportsStateSelectedPeriod(this.formattedPeriod, this.response);
}

class ReportsStateSelectedPeriodLoading implements ReportsState {
  final String formattedPeriod;

  const ReportsStateSelectedPeriodLoading(this.formattedPeriod);
}
