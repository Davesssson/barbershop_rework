import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/models/availability/availability_time_slot_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_model.freezed.dart';
part 'availability_model.g.dart';

@freezed
class Availability with _$Availability{
  const Availability._();

  factory Availability({
    String? id,
    List<AvailabilityTimeSlot>? slots,

  })= _Availability;

  factory Availability.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! ;
    return Availability.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }

  factory Availability.fromDocumentCustom(DocumentSnapshot doc){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Availability(
      slots:     data.keys.map((element) {
      return AvailabilityTimeSlot.fromJson(doc[element]);
    }).toList(),).copyWith(id:doc.id);
  }

  factory Availability.fromJson(Map<String, dynamic> json) => _$AvailabilityFromJson(json);
}