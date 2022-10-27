import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/models/responses/marker_response_item.dart';
import 'package:flutter_shopping_list/ui/map_screen/map_screen.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

//https://github.com/DarshanGowda0/GeoFlutterFire/issues/27

abstract class BaseCitiesRepository {
  Future<List<String>> retrieveCities();
}

final citiesRepositoryProvider = Provider<CitiesRepository>((ref) => CitiesRepository(ref.read));

class CitiesRepository implements BaseCitiesRepository {
  final Reader _read;

  const CitiesRepository(this._read);


  @override
  Future<List<String>> retrieveCities()async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCities] - Retrieving cities. . .");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').get();
      final cities =  snap.docs.map((doc) => doc['city'].toString()).toSet().toList();
      developer.log("[cities = " + cities.toString());
      return cities;
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving cities" + e.message!);
      throw CustomException(message: e.message);
    }
  }

  //NOT IN USE
  Future<Set<Marker>> retrieveCityMarkers(String city)async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkers] - Retrieving cityMarkers. . .");
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
      }).toSet();
      developer.log("[markers = " + markers.toString());
      return markers;
    } on FirebaseException catch (e) {
      developer.log("[cities_repository.dart][CitiesRepository][retrieveCities] - Failure during retrieving city Markers.");
      throw CustomException(message: e.message);
    }
  }

  Future<Set<MarkerResponseItem>> retrieveCityMarkers2()async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkers2] - Retrieve cityMarkers. . .");
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
      //retrieveCityMarkersGeoLocation2();
      return markers;
    } on FirebaseException catch (e) {
      developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkers2] - retrieveCityMarkers retrieved exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<Stream<List<DocumentSnapshot>>> retrieveCityMarkersGeoLocation()async {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkersGeoLocation] - Retrieving City Markers for geolocation. . .");
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: 47.497913, longitude:19.040236);
    try {
      final collectionReference = await _read(firebaseFirestoreProvider).collection('barbershops');
      double radius = 100;
      String field = 'point';
      print("itt vagyok");
       Stream<List<DocumentSnapshot>> stream = await geo.collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: field);
/*      Set<MarkerResponseItem>> items =await
          stream.last.map((e) {
          GeoPoint gp = e['location'];
          return MarkerResponseItem(
              city : e['city'],
              marker : Marker(
                markerId: MarkerId(e.id),
                position: LatLng(gp.latitude,gp.longitude),
              )
          );
        });

      print("items"+items.toString());
      return items;*/
      stream.forEach((element) {
        element.forEach((element2) {print("printing"+element2.data().toString()); });
      });
      return stream;
    } on FirebaseException catch (e) {
      developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkersGeoLocation] - Failure during retrieving city markers for geolaction.");
      throw CustomException(message: e.message);
    }
  }

  Stream<Set<MarkerResponseItem>> retrieveCityMarkersGeoLocation2(LatLng middlePoint, double radius)async* {
    developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkersGeoLocation] - Retrieving City Markers for geolocation. . .");
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: 47.497913, longitude:19.040236);
    //GeoFirePoint center = geo.point(latitude:middlePoint.latitude, longitude: middlePoint.longitude);
    try {
      final collectionReference = await _read(firebaseFirestoreProvider).collection('barbershops');
      //final r = _read(radiusProvider);
      print("r=" + radius.toString());
      //double radius = 10;
      String field = 'point';
      Stream<List<DocumentSnapshot>> stream = geo
          .collection(collectionRef: collectionReference)
          .within(
            center: center,
            radius: radius,
            field: field
      );

       yield* stream.map((List<DocumentSnapshot> documentList) {
        return documentList.map((doc)   {
          print("heloka itt vagyok");
          print(doc.data().toString());
          GeoPoint gp = doc['location'];
          return MarkerResponseItem(
              city : doc['city'],
              marker : Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(gp.latitude,gp.longitude),
              )
          );
        }).toSet();
      });
/*      final markerResponseItems = await stream.first.then((documents) => documents.map((doc) {
        print("heloka");
        print(doc.data().toString());
        GeoPoint gp = doc['location'];
        return MarkerResponseItem(
            city : doc['city'],
            marker : Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(gp.latitude,gp.longitude),
            )
        );
      }).toSet());*/
/*      markerResponseItems.forEach((element) {print(element);});
      return markerResponseItems;*/
    } on FirebaseException catch (e) {
      developer.log("[cities_repository.dart][CitiesRepository][retrieveCityMarkersGeoLocation] - Failure during retrieving city markers for geolaction.");
      throw CustomException(message: e.message);
    }
  }


}
