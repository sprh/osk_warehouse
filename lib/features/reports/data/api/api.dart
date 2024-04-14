import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import 'models/reports_request.dart';
import 'models/reports_response.dart';

abstract class ReportsApi {
  const factory ReportsApi(DioClient dioClient) = _ReportsApi;

  Future<ReportsResponse> getReports(ReportsRequest request);

  Future<Uint8List> createFile(ReportsRequest request);
}

class _ReportsApi implements ReportsApi {
  final DioClient _dioClient;

  const _ReportsApi(this._dioClient);

  @override
  Future<ReportsResponse> getReports(ReportsRequest request) async {
    final response = await _dioClient.core.post<Map<String, dynamic>>(
      _ApiConstants.reports,
      data: request.toJson(),
    );

    return ReportsResponse.fromJson(response.data!);
  }

  @override
  Future<Uint8List> createFile(ReportsRequest request) async {
    final response = await _dioClient.core.post<Uint8List?>(
      _ApiConstants.reportsFile,
      data: request.toJson(),
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    return response.data!;
  }
}

class _ApiConstants {
  static const reports = '/reports';
  static const reportsFile = '/reports/file';
}
