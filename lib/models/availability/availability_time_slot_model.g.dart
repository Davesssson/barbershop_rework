// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AvailabilityTimeSlot _$$_AvailabilityTimeSlotFromJson(
        Map<String, dynamic> json) =>
    _$_AvailabilityTimeSlot(
      available: json['available'] as bool?,
      end: json['end'] as int?,
      start: json['start'] as int?,
    );

Map<String, dynamic> _$$_AvailabilityTimeSlotToJson(
        _$_AvailabilityTimeSlot instance) =>
    <String, dynamic>{
      'available': instance.available,
      'end': instance.end,
      'start': instance.start,
    };
