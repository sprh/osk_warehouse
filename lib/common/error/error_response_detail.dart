import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response_detail.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponseDetail {
  final String? detail;

  const ErrorResponseDetail(this.detail);

  factory ErrorResponseDetail.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDetailFromJson(json);
}

extension ErrorResponseDetailX on Exception {
  String? get localizedErrorMessage {
    final e = this;
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map) {
        final json = Map<String, dynamic>.from(data);
        final errorMessage = ErrorResponseDetail.fromJson(json);
        return errorMessage.detail;
      }
    }
    return null;
  }
}
