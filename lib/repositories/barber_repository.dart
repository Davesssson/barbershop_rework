import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import '../models/barber/barber_model.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

abstract class BaseBarberRepository {
  Future<List<Barber>> retrieveBarbers();
  Future<Barber> retrieveSingleBarbersFromShop(String id);
  Future<List<Barber>> retrieveBarbersFromShop(List<String> id);
}

final barberRepositoryProvider = Provider<BarberRepository>((ref) => BarberRepository(ref.read));

class BarberRepository implements BaseBarberRepository{
  final Reader _read;
  const BarberRepository(this._read);

  @override
  Future<List<Barber>> retrieveBarbers() async {
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbers] - Barbers retrieved.");
    try {
      final snap =
      await _read(firebaseFirestoreProvider).collection('barbers').get();
      return snap.docs.map((doc) => Barber.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbershops] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Barber> retrieveSingleBarbersFromShop(String id) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveSingleBarbersFromShop] - Barbers retrieved.");
    try {
      final snap =
       await  _read(firebaseFirestoreProvider).collection('barbers').doc(id).get().then((value) => Barber.fromJson(value.data()!)); //QueryDocSnapshop


      // List<Barber> asd=[];
     // asd.add(snap);
     // return asd;
       return snap;
      
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveSingleBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }

  }

  @override
  Future<List<Barber>> retrieveBarbersFromShop(List<String> ids) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieved.");
    try {//EZ JÓ DE CSAK 10 IG MUKODIK
      // final snap = await _read(firebaseFirestoreProvider).collection('barbers').where('__name__',whereIn: ids).get();;
      // return snap.docs.map((doc) => Barber.fromDocument(doc)).toList();
      List<Barber> barbers = [];
      ids.forEach((id)async {
        final snap = await  _read(firebaseFirestoreProvider).collection('barbers').doc(id).get().then((value) => Barber.fromJson(value.data()!));
        barbers.add(snap);
      });
      return barbers;
    } on FirebaseException catch (e) {
      developer.log("[barbershops_repository.dart][BarbershopRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }

  }
}
