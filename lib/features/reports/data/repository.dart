import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/interface/repository.dart';
import 'api/api.dart';
import 'api/models/reports_request.dart';
import 'api/models/reports_response.dart';

abstract class ReportsRepository extends Repository<ReportsResponse> {
  factory ReportsRepository(ReportsApi api) = _ReportsRepository;

  Future<void> getReports(List<DateTime> period);

  Future<Uint8List?> downloadFile(List<DateTime> period);

  /// returns file path
  Future<String?> saveFileToApplicationDirectory(
    String name,
    Uint8List content,
  );

  /// returns file path
  Future<String?> saveFileToDownloads(String name, Uint8List content);

  Future<void> shareFile(String path, String reportName);

  Future<void> openFile(String path);
}

class _ReportsRepository extends Repository<ReportsResponse>
    implements ReportsRepository {
  final ReportsApi _api;
  late final _deviceInfo = DeviceInfoPlugin();

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
    } on Exception catch (e) {
      onError(e: e, fallbackMessage: 'Не удалось получить список отчетов');
    }
  }

  @override
  Future<Uint8List?> downloadFile(List<DateTime> period) async {
    try {
      final file = await _api.createFile(_formatRequest(period));
      return file;
    } on Exception catch (e) {
      onError(e: e, fallbackMessage: 'Не удалось получить отчет');
      return null;
    }
  }

  @override
  Future<void> shareFile(String path, String reportName) async {
    try {
      await Share.shareXFiles(
        [XFile(path)],
        text: 'Отчет $reportName',
      );
    } on Exception catch (e) {
      onError(e: e, fallbackMessage: 'Не удалось поделиться файлом');
    }
  }

  @override
  Future<String?> saveFileToApplicationDirectory(
    String name,
    Uint8List content,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$name.xlsx';

    return _saveFile(filePath, content);
  }

  @override
  Future<String?> saveFileToDownloads(String name, Uint8List content) async {
    if (!Platform.isAndroid) {
      return null;
    }

    final status = await _requestStoragePermissions();
    if (!status) {
      onError(
        e: null,
        fallbackMessage:
            'Для сохранения файла нужно разрешить доступ к памяти устройства',
      );
      return null;
    }

    // general downloads
    // https://stackoverflow.com/a/68760026
    final directory = Directory('/storage/emulated/0/Download');

    final filePath = '${directory.path}/$name.xlsx';

    return _saveFile(filePath, content);
  }

  Future<String?> _saveFile(String filePath, Uint8List content) async {
    try {
      final file = File(filePath);
      await file.writeAsBytes(content);
      return filePath;
    } on Exception {
      onError(
        fallbackMessage: 'Не удалось сохранить файл',
        e: null,
      );
    }

    return null;
  }

  @override
  Future<void> openFile(String path) async {
    try {
      final result = await OpenFile.open(path);
      if (result.type != ResultType.done) {
        onError(
          fallbackMessage: 'Не удалось открыть файл',
          e: null,
        );
      }
    } on Exception {
      onError(e: null, fallbackMessage: 'Не удалось открыть файл');
    }
  }

  ReportsRequest _formatRequest(List<DateTime> period) => ReportsRequest(
        interval: ReportsRequestInterval(
          fromDate: period.first.withMinTime,
          toDate: period.last.withMaxTime,
        ),
      );

  Future<bool> _requestStoragePermissions() async {
    if (Platform.isAndroid) {
      if ((await _deviceInfo.androidInfo).version.sdkInt >= 33) {
        final status = await Permission.manageExternalStorage.request();
        return status == PermissionStatus.granted;
      } else {
        final status = await Permission.storage.request();
        return status == PermissionStatus.granted;
      }
    }

    return false;
  }
}

extension on DateTime {
  DateTime get withMinTime => DateTime(year, month, day);

  DateTime get withMaxTime => DateTime(year, month, day, 23, 59, 59, 999);
}
