import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import '../../../common/interface/repository_subscriber.dart';
import '../../../common/utils/date_time_formatted.dart';
import '../../../common/utils/kotlin_utils.dart';
import '../../../core/navigation/manager/account_scope_navigation_manager.dart';
import '../data/api/models/reports_response.dart';
import '../data/repository.dart';

part 'event.dart';
part 'state.dart';

abstract class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  static ReportsBloc of(BuildContext context) => BlocProvider.of(context);

  factory ReportsBloc(
    AccountScopeNavigationManager navigationManager,
    ReportsRepository repository,
  ) = _ReportsBloc;
}

class _ReportsBloc extends Bloc<ReportsEvent, ReportsState>
    with RepositorySubscriber<ReportsResponse>
    implements ReportsBloc {
  final AccountScopeNavigationManager _navigationManager;
  final ReportsRepository _repository;

  List<DateTime> selectedPeriod = <DateTime>[];

  _ReportsBloc(this._navigationManager, this._repository)
      : super(ReportsStateNoSelectedPeriod()) {
    on<ReportsEvent>(_onEvent);
  }

  @override
  Repository<ReportsResponse> get repository => _repository;

  Future<void> _onEvent(
    ReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    switch (event) {
      case ReportsEventInitialize():
        _repository.start();
        start();
      case _ReportsEventOnData():
        final period =
            (state as ReportsStateSelectedPeriodLoading).formattedPeriod;
        emit(ReportsStateSelectedPeriod(period, event.value, false));
      case ReportsEventOpenCalendar():
        await _openCalendar();
      case _RepositoryEventOnSelectedPeriodChanged():
        await _onSelectedPeriodChanged(event.selectedPeriod, emit);
      case ReportsEventDownloadFile():
        await _onDownloadFile(emit);
    }
  }

  @override
  void onData(ReportsResponse value) => add(_ReportsEventOnData(value));

  @override
  void onLoading(bool loading) {}

  @override
  void onRepositoryError(RepositoryLocalizedError error) =>
      _navigationManager.showSomethingWentWrontDialog(
        error.message,
      );

  Future<void> _openCalendar() async {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: const Color(0xFFFFCFA3),
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      lastDate: DateTime.now(),
    );

    await _navigationManager.openCalenarPicker(
      config,
      (value) => add(
        _RepositoryEventOnSelectedPeriodChanged(selectedPeriod: value),
      ),
      selectedPeriod,
    );
  }

  Future<void> _onSelectedPeriodChanged(
    List<DateTime> value,
    Emitter<ReportsState> emit,
  ) async {
    selectedPeriod = value;
    final formattedPeriod = DateTimeFormatter.formatSelectedPeriod(
      currentDate: DateTime.now(),
      selectedPeriod: selectedPeriod,
      locale: _navigationManager.navigatorKey.currentContext?.let(
        Localizations.localeOf,
      ),
    );
    emit(ReportsStateSelectedPeriodLoading(formattedPeriod));
    await _repository.getReports(selectedPeriod);
  }

  Future<void> _onDownloadFile(Emitter<ReportsState> emit) async {
    emit((state as ReportsStateSelectedPeriod).copyWith(loading: true));
    final file = await _repository.downloadFile(selectedPeriod);
    if (file != null) {
      await _repository.saveAndShareFile(
        (state as ReportsStateSelectedPeriod).formattedPeriod,
        file,
      );
    }
    emit((state as ReportsStateSelectedPeriod).copyWith(loading: false));
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
