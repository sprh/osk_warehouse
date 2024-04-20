import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/error/repository_localized_error.dart';
import '../../../common/interface/repository.dart';
import 'api/api.dart';
import 'api/models/reports_request.dart';
import 'api/models/reports_response.dart';

abstract class ReportsRepository extends Repository<ReportsResponse> {
  factory ReportsRepository(ReportsApi api) = _ReportsRepository;

  Future<void> getReports(List<DateTime> period);

  Future<Uint8List?> downloadFile(List<DateTime> period);

  Future<void> saveAndShareFile(String name, Uint8List content);
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
        _formatRequest(period),
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

  @override
  Future<Uint8List?> downloadFile(List<DateTime> period) async {
    try {
      final file = await _api.createFile(_formatRequest(period));
      return file;
    } on Exception {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось получить отчет',
        ),
      );
      return null;
    }
  }

  @override
  Future<void> saveAndShareFile(String name, Uint8List content) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$name.xlsx';

      // Сохранение файла
      final file = File(filePath);
      await file.writeAsBytes(content);
      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Отчет $name',
      );
    } on Exception {
      emitError(
        RepositoryLocalizedError(
          message: 'Не удалось поделиться файлом',
        ),
      );
    }
  }

  ReportsRequest _formatRequest(List<DateTime> period) => ReportsRequest(
        interval: ReportsRequestInterval(
          fromDate: period.first.withMinTime,
          toDate: period.last.withMaxTime,
        ),
      );
}

extension on DateTime {
  DateTime get withMinTime => DateTime(year, month, day);

  DateTime get withMaxTime => DateTime(year, month, day, 23, 59, 59, 999);
}
