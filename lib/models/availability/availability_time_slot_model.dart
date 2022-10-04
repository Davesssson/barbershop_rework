import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_time_slot_model.freezed.dart';
part 'availability_time_slot_model.g.dart';

@freezed
class AvailabilityTimeSlot with _$AvailabilityTimeSlot{
  const AvailabilityTimeSlot._();

  factory AvailabilityTimeSlot({
    bool? available,
    int? end,
    int? start,
  })= _AvailabilityTimeSlot;

  factory AvailabilityTimeSlot.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return AvailabilityTimeSlot.fromJson(data as Map<String,dynamic>);
  }

  factory AvailabilityTimeSlot.fromJson(Map<String, dynamic> json) => _$AvailabilityTimeSlotFromJson(json);
}