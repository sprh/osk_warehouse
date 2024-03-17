import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/application/application_dto.dart';
import '../models/applications_list/applications_list_response.dart';
import '../models/create_application/create_application_dto.dart';

abstract class ApplicationsApi {
  factory ApplicationsApi(DioClient dio) = _ApplicationApi;

  Future<ApplicationsListResponse> getApplications([String? cursor]);

  Future<ApplicationDto> getApplication(String id);

  Future<ApplicationDto> createApplication(
    CreateApplicationDto dto,
    String idempotencyToken,
  );
}

class _ApplicationApi implements ApplicationsApi {
  final DioClient _dio;

  const _ApplicationApi(this._dio);

  @override
  Future<ApplicationsListResponse> getApplications([String? cursor]) async {
    final response = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.applicationsList,
      queryParameters: {
        _ApiConstants.limit: 10,
        if (cursor != null) _ApiConstants.cursor: cursor,
      },
    );

    return ApplicationsListResponse.fromJson(response.data!);
  }

  @override
  Future<ApplicationDto> createApplication(
    CreateApplicationDto dto,
    String idempotencyToken,
  ) async {
    final response = await _dio.core.post<Map<String, dynamic>>(
      _ApiConstants.applications,
      data: dto.toJson(),
      options: Options(
        headers: {
          _ApiConstants.requestIdempotencyToken: idempotencyToken,
        },
      ),
    );

    return ApplicationDto.fromJson(response.data!);
  }

  @override
  Future<ApplicationDto> getApplication(String id) {
    // TODO: implement getApplication
    throw UnimplementedError();
  }
}

class _ApiConstants {
  static const applications = '/applications';
  static const applicationsList = '/applications/list';

  // header
  static const requestIdempotencyToken = 'x-request-idempotency-token';

  // query
  static const limit = 'limit';
  static const cursor = 'cursor';
}
