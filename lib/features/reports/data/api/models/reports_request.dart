import 'package:json_annotation/json_annotation.dart';

part 'reports_request.g.dart';

@JsonSerializable(createFactory: false)
class ReportsRequest {
  final ReportsRequestInterval interval;

  const ReportsRequest({
    required this.interval,
  });

  Map<String, dynamic> toJson() => _$ReportsRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class ReportsRequestInterval {
  final DateTime fromDate;
  final DateTime toDate;

  const ReportsRequestInterval({
    required this.fromDate,
    required this.toDate,
  });

  Map<String, dynamic> toJson() => _$ReportsRequestIntervalToJson(this);
}
