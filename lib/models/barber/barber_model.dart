
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'barber_model.freezed.dart';
part 'barber_model.g.dart';

@freezed
class Barber with _$Barber{
  const Barber._();

  factory Barber({
    String? id,
    String? name,

  })= _Barber;

  factory Barber.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return Barber.fromJson(data as Map<String,dynamic>).copyWith(id: doc.id);
  }

  factory Barber.fromJson(Map<String, dynamic> json) => _$BarberFromJson(json);
}