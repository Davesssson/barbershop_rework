import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

abstract class BaseBarbershopRepository {
  Future<List<Barbershop>> retrieveBarbershops();
  Future<Barbershop> retrieveSingleBarbershop(String id);
}

final barbershopRepositoryProvider = Provider<BarbershopRepository>((ref) => BarbershopRepository(ref.read));

class BarbershopRepository implements BaseBarbershopRepository{
  final Reader _read;
  const BarbershopRepository(this._read);

  @override
  Future<List<Barbershop>> retrieveBarbershops() async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershops] - Barbershops retrieved.");
    try {
      final snap =
          await _read(firebaseFirestoreProvider).collection('barbershops').get();
      return snap.docs.map((doc) => Barbershop.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershops] - Barbershop retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Barbershop> retrieveSingleBarbershop(String id)async {
    developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveSingleBarbershop] - Barbers retrieved.");
    try {
      developer.log("message = " +id);
      final snap =
          //await  _read(firebaseFirestoreProvider).collection('barbershops').doc('7HTJ8DF8hFwUnrL566Wc').get().then((value) => Barbershop.fromJson(value.data()!)); //QueryDocSnapshop
          await  _read(firebaseFirestoreProvider).collection('barbershops').doc(id).get().then((value) => Barbershop.fromDocument(value)); //QueryDocSnapshop


      // List<Barber> asd=[];
      // asd.add(snap);
      // return asd;
      return snap;

    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveSingleBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }

  }

}

