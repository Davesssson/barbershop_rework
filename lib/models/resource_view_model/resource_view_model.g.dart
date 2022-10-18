// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResourceViewModel _$$_ResourceViewModelFromJson(Map<String, dynamic> json) =>
    _$_ResourceViewModel(
      barber: json['barber'] == null
          ? null
          : Barber.fromJson(json['barber'] as Map<String, dynamic>),
      workDayAvailability: (json['workDayAvailability'] as List<dynamic>?)
          ?.map((e) => WorkDayAvailability.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ResourceViewModelToJson(
        _$_ResourceViewModel instance) =>
    <String, dynamic>{
      'barber': instance.barber,
      'workDayAvailability': instance.workDayAvailability,
      'bookings': instance.bookings,
    };
