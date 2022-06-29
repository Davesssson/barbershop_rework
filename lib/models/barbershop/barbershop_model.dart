import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'barbershop_model.freezed.dart';
part 'barbershop_model.g.dart';

@freezed
class Barbershop with _$Barbershop{
  const factory Barbershop({
    String? id,
    String? name,
    String? main_image,
    //GeoPoint? location,
    String? places_id,

  })= _Barbershop;

  factory Barbershop.fromJson(Map<String, dynamic> json) => _$BarbershopFromJson(json);

  factory Barbershop.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()!;
    return Barbershop.fromJson(data as Map<String,dynamic>).copyWith(id: doc.id);
  }

  //Map<String, dynamic> toDocument() => toJson()..remove('id');
}