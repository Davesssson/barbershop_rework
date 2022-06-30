

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
// https://medium.com/@hasimyerlikaya/flutter-custom-datetime-serialization-with-jsonconverter-5f57f93d537

class CustomGeoPointConverter implements JsonConverter<GeoPoint,Map<String,dynamic>>{
  const CustomGeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json){
    double lat = json['latitude'];
    double lng = json['longitude'];
    return GeoPoint(lat,lng);
  }

  @override
  Map<String, dynamic> toJson(GeoPoint gp) {
    return <String, dynamic>{
      'latitude': gp.latitude,
      'longitude': gp.longitude,
    };

  }


}
