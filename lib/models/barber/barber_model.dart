import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barber_model.freezed.dart';
part 'barber_model.g.dart';

@freezed
class Barber with _$Barber{
  const Barber._();

  factory Barber({
    String? barbershop_id,
    String? id,
    String? name,
    String? description,
    String? prof_pic,
    List<String>? works,

  })= _Barber;

  factory Barber.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return Barber.fromJson(data as Map<String,dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');

  factory Barber.fromJson(Map<String, dynamic> json) => _$BarberFromJson(json);
}