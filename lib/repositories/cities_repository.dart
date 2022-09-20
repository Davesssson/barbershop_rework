import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/models/responses/marker_response_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

abstract class BaseCitiesRepository {
  Future<List<String>> retrieveCities();
}

final citiesRepositoryProvider = Provider<CitiesRepository>((ref) => CitiesRepository(ref.read));

class CitiesRepository implements BaseCitiesRepository {
  final Reader _read;

  const CitiesRepository(this._read);


  @override
  Future<List<String>> retrieveCities()async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCities] - retrieveCities retrieved.");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').get();
      final cities =  snap.docs.map((doc) => doc['city'].toString()).toSet().toList();
      developer.log("[cities = " + cities.toString());
      return cities;
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][CitiesRepository][retrieveCities] - retrieveCities retrieved exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<Set<Marker>> retrieveCityMarkers(String city)async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkers] - retrieveCityMarkers retrieved.");
    try {
      print(city);
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').get();
      final asd = snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
      LatLng latLng1=LatLng(47.4450642, 19.0997709);
      LatLng latLng2=LatLng(47.49225, 19.0600528);
      final markers =  snap.docs.map((doc) {
        GeoPoint gp = doc['location'];
        return Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(gp.latitude,gp.longitude),
        );
        //position:LatLng( doc['location']['latitude'], doc['location']['longitude']))
      }).toSet();
      developer.log("[markers = " + markers.toString());
      return markers;
    } on FirebaseException catch (e) {
      developer.log("[cities_repository.dart][CitiesRepository][retrieveCities] - retrieveCityMarkers retrieved exception.");
      throw CustomException(message: e.message);
    }
  }
  Future<Set<MarkerResponseItem>> retrieveCityMarkers2()async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkers2] - retrieveCityMarkers2 retrieved.");

    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').get();
      final markers =  snap.docs.map((doc) {
        GeoPoint gp = doc['location'];
        return MarkerResponseItem(
            city : doc['city'],
            marker : Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(gp.latitude,gp.longitude),
            )
        );
      }).toSet();
      developer.log("[markers = " + markers.toString());
      return markers;
    } on FirebaseException catch (e) {
      developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkers2] - retrieveCityMarkers retrieved exception.");
      throw CustomException(message: e.message);
    }
  }

}
