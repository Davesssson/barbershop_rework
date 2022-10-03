import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_model.freezed.dart';
part 'availability_model.g.dart';

@freezed
class Availability with _$Availability{
  const Availability._();

  factory Availability({
    String? barbershop_id,
    String? id,
    String? name,
    String? description,
    String? prof_pic,
    List<String>? works,

  })= _Availability;

  factory Availability.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return Availability.fromJson(data as Map<String,dynamic>).copyWith(id: doc.id);
  }

  factory Availability.fromJson(Map<String, dynamic> json) => _$AvailabilityFromJson(json);
}