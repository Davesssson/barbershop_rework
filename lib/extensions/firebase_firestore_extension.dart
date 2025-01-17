import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference usersListRef(String userId) =>
      collection('lists').doc(userId).collection('userList');
}

extension Serialization on GeoPoint{
  GeoPoint fromJson(Map<String, dynamic> json){
    double lat = json['latitude'];
    double lng = json['longitude'];
    return GeoPoint(lat,lng);
  }

  Map<String, dynamic> toJson(GeoPoint gp) {
    return <String, dynamic>{
      'latitude': gp.latitude,
      'longitude': gp.longitude,
    };
}
}

