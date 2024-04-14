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

  Future<ApplicationDto> updateApplication(
    CreateApplicationDto dto,
    String id,
  );

  Future<void> reject(String id);

  Future<void> approve(String id);

  Future<void> delete(String id);
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
  Future<ApplicationDto> getApplication(String id) async {
    final reponse = await _dio.core.get<Map<String, dynamic>>(
      _ApiConstants.applications,
      queryParameters: {
        _ApiConstants.applicationsId: id,
      },
    );

    return ApplicationDto.fromJson(reponse.data!);
  }

  @override
  Future<Object?> approve(String id) async {
    final response = await _dio.core.put<Object?>(
      _ApiConstants.applicationsApprove,
      queryParameters: {
        _ApiConstants.applicationsId: id,
      },
    );

    return response.data!;
  }

  @override
  Future<Object?> delete(String id) async {
    final response = await _dio.core.delete<Object?>(
      _ApiConstants.applications,
      queryParameters: {
        _ApiConstants.applicationsId: id,
      },
    );

    return response.data!;
  }

  @override
  Future<Object?> reject(String id) async {
    final response = await _dio.core.put<Object?>(
      _ApiConstants.applicationsReject,
      queryParameters: {
        _ApiConstants.applicationsId: id,
      },
    );

    return response.data!;
  }

  @override
  Future<ApplicationDto> updateApplication(
    CreateApplicationDto dto,
    String id,
  ) async {
    final response = await _dio.core.patch<Map<String, dynamic>>(
      _ApiConstants.applications,
      data: dto.toJson(),
      queryParameters: {
        _ApiConstants.applicationsId: id,
      },
    );

    return ApplicationDto.fromJson(response.data!);
  }
}

class _ApiConstants {
  static const applications = '/applications';
  static const applicationsList = '/applications/list';
  static const applicationsReject = '/applications/reject';
  static const applicationsApprove = '/applications/approve';

  // header
  static const requestIdempotencyToken = 'x-request-idempotency-token';

  // query
  static const limit = 'limit';
  static const cursor = 'cursor';
  static const applicationsId = 'id';
}
