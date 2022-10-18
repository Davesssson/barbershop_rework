// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_day_availability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WorkDayAvailability _$$_WorkDayAvailabilityFromJson(
        Map<String, dynamic> json) =>
    _$_WorkDayAvailability(
      id: json['id'] as String?,
      barberId: json['barberId'] as String?,
      start: json['start'] as int?,
      end: json['end'] as int?,
    );

Map<String, dynamic> _$$_WorkDayAvailabilityToJson(
        _$_WorkDayAvailability instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barberId': instance.barberId,
      'start': instance.start,
      'end': instance.end,
    };
