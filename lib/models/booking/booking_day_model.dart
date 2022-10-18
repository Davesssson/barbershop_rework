import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'booking_model.dart';

part 'booking_day_model.freezed.dart';
part 'booking_day_model.g.dart';

@freezed
class BookingDay with _$BookingDay{
  const BookingDay._();

  factory BookingDay({
    String? id,
    List<Booking>? bookings,
  })= _BookingDay;

  factory BookingDay.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! ;
    return BookingDay.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  factory BookingDay.fromDocumentCustom(DocumentSnapshot doc){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return BookingDay(
      bookings:data.keys.map((element) {
        return Booking.fromJson(doc[element]);
      }).toList(),).copyWith(id:doc.id);
  }


  factory BookingDay.fromJson(Map<String, dynamic> json) => _$BookingDayFromJson(json);
}