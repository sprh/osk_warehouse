import '../../../../core/network/dio_client.dart';
import 'models/reports_request.dart';
import 'models/reports_response.dart';

abstract class ReportsApi {
  const factory ReportsApi(DioClient dioClient) = _ReportsApi;

  Future<ReportsResponse> getReports(ReportsRequest request);
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
}

class _ApiConstants {
  static const reports = '/reports';
}
