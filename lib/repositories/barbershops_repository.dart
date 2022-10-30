import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/barber/barber_model.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/repositories/auth_repository.dart';
import 'package:flutter_shopping_list/repositories/service_repository.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

abstract class BaseBarbershopRepository {
  Future<List<Barbershop>> retrieveBarbershops();
  Future<Barbershop> retrieveSingleBarbershop(String id);
  //Future<List<String>> retrieveCities();
}

final barbershopRepositoryProvider = Provider<BarbershopRepository>((ref) => BarbershopRepository(ref.read));

class BarbershopRepository implements BaseBarbershopRepository{
  final Reader _read;
  const BarbershopRepository(this._read);

  @override
  Future<List<Barbershop>> retrieveBarbershops() async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershops] - Retriving Barbershops.");
    try {
        final snap = await _read(firebaseFirestoreProvider).collection('barbershops')
            .where('isVisible',isEqualTo: true)
            .where('isDeleted',isEqualTo: false)/*.limit(3)*/
            .get();
        final asd = await _read(serviceRepositoryProvider).retrieveServiceTags();
        print(asd);
        return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
        developer.log("Failure during retrieving barbershops" + e.message!);
        throw CustomException(message: e.message);
    }
  }

  Future<List<Barbershop>> retrieveMoreBarbershops(Barbershop? b) async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveMoreBarbershops] - Retrieving MORE barrbershops. . .");
    try {
      final previoussSnap = await  _read(firebaseFirestoreProvider).collection('barbershops').doc(b!.id).get();
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops')
          .startAfterDocument(previoussSnap)
          .where('isVisible',isEqualTo: true)
          .where('isDeleted',isEqualTo: false)
          .limit(3)
          .get();
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving MORE barbershops" + e.message!);
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Barbershop> retrieveSingleBarbershop(String id)async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveSingleBarbershop] - Retrieving barbershop ${id}. . .");
    try {
      final snap =
          await  _read(firebaseFirestoreProvider).collection('barbershops').doc(id).get().then((value) => Barbershop.fromDocument(value)); //QueryDocSnapshop
      return snap;
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving single barbershops" + e.message!);
      throw CustomException(message: e.message);
    }

  }

  Future<List<Barbershop>> retrievePaginatedBarbershops(Barbershop? item) async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrievePaginatedBarbershops] - Retrieving paginated barbershops. . .");
    final itemsCollectionRef = await  _read(firebaseFirestoreProvider).collection('barbershops');
    try {
      print("try 1");
      if (item == null) {
        final documentSnapshot = await itemsCollectionRef
            .limit(3)
            .get();
        return documentSnapshot.docs
            .map<Barbershop>(
                (data) => Barbershop.fromDocument(data)).toList();
      } else {
        print("else 1");
        final documentSnapshot = await itemsCollectionRef
            .startAfter([item.id])
            .limit(1000)
            .get();

        return documentSnapshot.docs
            .map<Barbershop>(
                (data) => Barbershop
                .fromDocument(data))
            .toList();
      }
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving paginated barbershops" + e.message!);
      throw CustomException(message: e.message);
    }
  }

  //NOT IN USE
  Future<List<Barbershop>> retrieveBarbershopsServices(List<String> tags) async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershopsServices] - retrieveBarbershopsServices retrieved.");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops')
          .where('isVisible',isEqualTo: true)
          .where('isDeleted',isEqualTo: false)
          .where('tags',arrayContains: tags).get();
      //this.retrieveCities();
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershopsServices] - retrieveBarbershopsServices retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Barbershop>> retrieveFeaturedBarbershops() async{
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveFeaturedBarbershops] - Retrieving Featured barbershops. . .");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops')
          .where('isVisible',isEqualTo: true)
          .where('isDeleted',isEqualTo: false)
          .where('featured',isEqualTo: true)
          .get();
      print("snap fetured");
      print(snap.toString());
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving paginated barbershops" + e.message!);
      throw CustomException(message: e.message);
    }
  }

  Future<String>createBarbershop({required String shopName, required String email,required String password})async{
    developer.log("[barbershops_repository.dart][BarbershopRepository][createBarbershop] - Creating barbershop. . .");
    try {
      Barbershop b = Barbershop(location: GeoPoint(12,12),name: shopName);
      final UserCredential? user = await _read(authRepositoryProvider).createUserWithEmailAndPassword(email, password,role:"admin");
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('barbershops')
          .add({
            "barbers":[],
            "city":"",
            "featured":false,
            "isDeleted":false, //!!
            "isVisible":false, //!!
            "location":GeoPoint(12,12),
            "main_image":"",
            "name":shopName,
            "places_id":"",
            "point":{
              "geohash":"",
              "geopoint":GeoPoint(12,12)
            },
            "services":[],
            "tags":[]
          });
      return docRef.id;

      //return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving paginated barbershops" + e.message!);
      throw CustomException(message: e.message);
    }
  }


}

