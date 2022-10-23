
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
class Service with _$Service{
  const Service._();

  factory Service({
    String? id,
    String? serviceTitle,
    int? servicePrice,
    String? serviceDescription,
    String? barbershop_id,
    Map<String, dynamic>? tags



  })= _Service;

  factory Service.empty() => Service(serviceTitle: "",servicePrice: 0,serviceDescription: "");

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

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

  factory Service.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String,dynamic>;
    return Service.fromJson(data/* as Map<String,dynamic>*/).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
