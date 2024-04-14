// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ReportsRequestToJson(ReportsRequest instance) =>
    <String, dynamic>{
      'interval': instance.interval.toJson(),
    };

Map<String, dynamic> _$ReportsRequestIntervalToJson(
        ReportsRequestInterval instance) =>
    <String, dynamic>{
      'from_date': instance.fromDate.toIso8601String(),
      'to_date': instance.toDate.toIso8601String(),
    };
