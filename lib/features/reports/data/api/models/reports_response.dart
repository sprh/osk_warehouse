import 'package:json_annotation/json_annotation.dart';

part 'reports_response.g.dart';

@JsonSerializable(createToJson: false)
class ReportsResponse {
  final List<String> header;
  final List<List<Object?>> items;

  const ReportsResponse({
    required this.header,
    required this.items,
  });

  factory ReportsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportsResponseFromJson(json);
}
