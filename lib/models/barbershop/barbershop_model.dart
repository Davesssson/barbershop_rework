import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/controllers/barber_controller.dart';
import 'package:flutter_shopping_list/extensions/firebase_firestore_extension.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:flutter_shopping_list/models/json_converter.dart';
import 'package:flutter_shopping_list/repositories/barber_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../barber/barber_model.dart';

part 'barbershop_model.freezed.dart';
part 'barbershop_model.g.dart';

//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
@freezed
class Barbershop with _$Barbershop{
  const Barbershop._();

   factory Barbershop({
    String? id,
    String? name,
    String? main_image,
    @CustomGeoPointConverter()
    required GeoPoint location,
    String? places_id,
    List<String>? barbers,

  })= _Barbershop;

  factory Barbershop.fromJson(Map<String, dynamic> json) => _$BarbershopFromJson(json);

  // factory Barbershop.fromDocument(DocumentSnapshot doc) {
  //   final data = doc.data()!;
  //   Map<String,dynamic> map ={
  //     'name':doc.get('name'),
  //     'places_id':doc.get('places_id'),
  //     'main_image':doc.get('main_image'),
  //     'location' : CustomGeoPointConverter().toJson(doc.get('location'))
  //   } ;
  //
  //   return Barbershop.fromJson(map).copyWith(id: doc.id);
  //  // return Barbershop.fromJson(data as Map<String,dynamic>).copyWith(id: doc.id);
  // }

  factory Barbershop.fromDocument(DocumentSnapshot doc) {
     final data = doc.data()! as Map<String,dynamic>;
     //TODO EZT ITT KI KELL JAVÍTANI
     data['location']=CustomGeoPointConverter().toJson(doc.get('location'));
     return Barbershop.fromJson(data/* as Map<String,dynamic>*/).copyWith(id: doc.id);
   }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}

