// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookingDay _$$_BookingDayFromJson(Map<String, dynamic> json) =>
    _$_BookingDay(
      id: json['id'] as String?,
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BookingDayToJson(_$_BookingDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookings': instance.bookings,
    };
