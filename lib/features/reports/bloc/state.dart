part of 'bloc.dart';

sealed class ReportsState {}

class ReportsStateNoSelectedPeriod implements ReportsState {}

class ReportsStateSelectedPeriod implements ReportsState {
  final String formattedPeriod;
  final ReportsResponse response;
  final bool loading;

  const ReportsStateSelectedPeriod(
    this.formattedPeriod,
    this.response,
    this.loading,
  );

  ReportsStateSelectedPeriod copyWith({
    String? formattedPeriod,
    ReportsResponse? response,
    bool? loading,
  }) =>
      ReportsStateSelectedPeriod(
        formattedPeriod ?? this.formattedPeriod,
        response ?? this.response,
        loading ?? this.loading,
      );
}

class ReportsStateSelectedPeriodLoading implements ReportsState {
  final String formattedPeriod;

  const ReportsStateSelectedPeriodLoading(this.formattedPeriod);
}
