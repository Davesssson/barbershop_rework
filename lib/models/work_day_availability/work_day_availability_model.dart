import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_day_availability_model.freezed.dart';
part 'work_day_availability_model.g.dart';

@freezed
class WorkDayAvailability with _$WorkDayAvailability{
  const WorkDayAvailability._();

  factory WorkDayAvailability({
    String? id,
    String? barberId,
    int? start,
    int? end

  })= _WorkDayAvailability;

  factory WorkDayAvailability.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! ;
    return WorkDayAvailability.fromJson(data as Map<String, dynamic>).copyWith(id: doc.id);
  }


  factory WorkDayAvailability.fromJson(Map<String, dynamic> json) => _$WorkDayAvailabilityFromJson(json);
}