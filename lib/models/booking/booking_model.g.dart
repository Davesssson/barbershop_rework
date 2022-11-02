// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Booking _$$_BookingFromJson(Map<String, dynamic> json) => _$_Booking(
      dateId: json['dateId'] as String?,
      uId: json['uId'] as String?,
      barberId: json['barberId'] as String?,
      start: json['start'] as int?,
      end: json['end'] as int?,
      userReserverId: json['userReserverId'] as String?,
      serviceId: json['serviceId'] as String?,
    );

Map<String, dynamic> _$$_BookingToJson(_$_Booking instance) =>
    <String, dynamic>{
      'dateId': instance.dateId,
      'uId': instance.uId,
      'barberId': instance.barberId,
      'start': instance.start,
      'end': instance.end,
      'userReserverId': instance.userReserverId,
      'serviceId': instance.serviceId,
    };
