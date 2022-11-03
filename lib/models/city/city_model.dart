import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converter.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

@freezed
class City with _$City {
  const City._();

  const factory City({
    String? id,
    String? cityName,
    @CustomGeoPointConverter()
    GeoPoint? location,
  }) = _City;

  factory City.Budapet() => City(id:"Budapest",cityName: 'Budapest', location: GeoPoint(47.497913,19.040236));
  factory City.empty() => City();


  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  factory City.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String,dynamic>;
    data['location']=CustomGeoPointConverter().toJson(doc.get('location'));
    return City.fromJson(data as Map<String,dynamic>).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
