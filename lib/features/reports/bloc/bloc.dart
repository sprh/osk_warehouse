import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/actions/actions_flex.dart';
import '../../../common/components/button/osk_button.dart';
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
      case ReportsEventSaveFile():
        await _onSaveFile(emit);
      case ReportsEventShareFile():
        await _onShareFile(emit);
      case _ReportsEventOpenFile():
        await _onOpenFile(emit, event.path);
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
      currentDate: DateTime.now(),
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

  Future<void> _onShareFile(Emitter<ReportsState> emit) async {
    emit((state as ReportsStateSelectedPeriod).copyWith(loading: true));

    final file = await _repository.downloadFile(selectedPeriod);
    if (file != null) {
      final formattedPeriod =
          (state as ReportsStateSelectedPeriod).formattedPeriod;
      final path = await _repository.saveFileToApplicationDirectory(
        formattedPeriod,
        file,
      );

      if (path != null) {
        await _repository.shareFile(path, formattedPeriod);
      }
    }

    emit((state as ReportsStateSelectedPeriod).copyWith(loading: false));
  }

  Future<void> _onSaveFile(Emitter<ReportsState> emit) async {
    emit((state as ReportsStateSelectedPeriod).copyWith(loading: true));

    final file = await _repository.downloadFile(selectedPeriod);
    if (file != null) {
      final formattedPeriod =
          (state as ReportsStateSelectedPeriod).formattedPeriod;
      final path = await _repository.saveFileToDownloads(
        formattedPeriod,
        file,
      );

      if (path != null) {
        await _navigationManager.showModalDialog(
          title: 'Файл $formattedPeriod скачался. Его можно найти в Загрузках',
          subtitle: 'Хотите открыть файл?',
          dismissible: true,
          actions: OskActionsFlex(
            widgets: [
              OskButton.minor(
                title: 'Не открывать',
                onTap: _navigationManager.popDialog,
              ),
              OskButton.main(
                title: 'Открыть файл',
                onTap: () {
                  add(_ReportsEventOpenFile(path));
                  _navigationManager.popDialog();
                },
              ),
            ],
          ),
        );
      }
    }

    emit((state as ReportsStateSelectedPeriod).copyWith(loading: false));
  }

  Future<void> _onOpenFile(Emitter<ReportsState> emit, String filePath) async {
    emit((state as ReportsStateSelectedPeriod).copyWith(loading: true));
    await _repository.openFile(filePath);
    emit((state as ReportsStateSelectedPeriod).copyWith(loading: false));
  }

  @override
  Future<void> close() {
    super.stop();
    return super.close();
  }
}
