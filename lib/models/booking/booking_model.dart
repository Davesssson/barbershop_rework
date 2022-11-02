import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
class Booking with _$Booking{
  const Booking._();

  factory Booking({
    String? dateId,
    String? uId,
    String? barberId,
    int? start,
    int? end,
    String? userReserverId,
    String? serviceId
  })= _Booking;

  factory Booking.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! ;
    return Booking.fromJson(data as Map<String, dynamic>).copyWith(dateId: doc.id);
  }


  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
}