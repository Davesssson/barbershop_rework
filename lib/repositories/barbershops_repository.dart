import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/repositories/service_repository.dart';
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
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershops] - Barbershops retrieved.");
    try {
        final snap = await _read(firebaseFirestoreProvider).collection('barbershops')/*.limit(3)*/.get();
        //this.retrieveCities();
        final asd = await _read(serviceRepositoryProvider).retrieveServiceTags();
        print(asd);
        return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
        developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershops] - Barbershop retrieve exception.");
        throw CustomException(message: e.message);
    }
  }

  Future<List<Barbershop>> retrieveMoreBarbershops(Barbershop? b) async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveMoreBarbershops] - More barbershops retrieved.");
    try {
      final previoussSnap = await  _read(firebaseFirestoreProvider).collection('barbershops').doc(b!.id).get();
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').startAfterDocument(previoussSnap).limit(3).get();
      //this.retrieveCities();
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveMoreBarbershops] - More barbershop retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Barbershop> retrieveSingleBarbershop(String id)async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveSingleBarbershop] - Single Barbershop retrieved.");
    try {
      final snap =
          await  _read(firebaseFirestoreProvider).collection('barbershops').doc(id).get().then((value) => Barbershop.fromDocument(value)); //QueryDocSnapshop
      return snap;
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveSingleBarbershop] - Single Barbershop retrieve exception.");
      throw CustomException(message: e.message);
    }

  }

  Future<List<Barbershop>> retrievePaginatedBarbershops(Barbershop? item) async {
    print(item);
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
      throw CustomException(message: e.message);
    }
  }

  Future<List<Barbershop>> retrieveBarbershopsServices(List<String> tags) async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershopsServices] - retrieveBarbershopsServices retrieved.");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').where('tags',arrayContains: tags).get();
      //this.retrieveCities();
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershopsServices] - retrieveBarbershopsServices retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Barbershop>> retrieveFeaturedBarbershops() async{
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveFeaturedBarbershops] - retrieveFeaturedBarbershops retrieved.");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('barbershops').where('featured',isEqualTo: 'true').get();
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveFeaturedBarbershops] - retrieveFeaturedBarbershops exception.");
      throw CustomException(message: e.message);
    }
  }
  }

}

