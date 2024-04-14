import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import 'api/api.dart';
import 'api/models/reports_request.dart';
import 'api/models/reports_response.dart';

abstract class ReportsRepository extends Repository<ReportsResponse> {
  factory ReportsRepository(ReportsApi api) = _ReportsRepository;

  Future<void> getReports(List<DateTime> period);
}

class _ReportsRepository extends Repository<ReportsResponse>
    implements ReportsRepository {
  final ReportsApi _api;

  _ReportsRepository(this._api);

  @override
  Future<void> getReports(List<DateTime> period) async {
    if (loading) {
      return;
    }

    try {
      final reports = await _api.getReports(
        ReportsRequest(
          interval: ReportsRequestInterval(
            fromDate: period.first.withMinTime,
            toDate: period.last.withMaxTime,
          ),
        ),
      );

      emit(reports);
    } on Exception {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить список отчетов',
        ),
      );
    }
  }
}

extension on DateTime {
  DateTime get withMinTime => DateTime(year, month, day);

  DateTime get withMaxTime => DateTime(year, month, day, 23, 59, 59, 999);
}
