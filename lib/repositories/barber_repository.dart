import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/availability/availability_model.dart';
import 'package:flutter_shopping_list/models/availability/availability_time_slot_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../general_providers.dart';
import '../models/barber/barber_model.dart';
import '../models/work_day_availability/work_day_availability_model.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

//https://firebase.google.com/docs/firestore/manage-data/add-data

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
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbers] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Barber> retrieveSingleBarbersFromShop(String id) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveSingleBarbersFromShop] - Barbers retrieved.");
    try {
      final snap =
       await  _read(firebaseFirestoreProvider).collection('barbers').doc(id).get().then((value) => Barber.fromJson(value.data()!)); //QueryDocSnapshop
       return snap;
      
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveSingleBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }

  }

  @override
  Future<List<Barber>> retrieveBarbersFromShop(List<String> ids) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieved from shop.");
    try {//EZ JÓ DE CSAK 10 IG MUKODIK
        final snap = await _read(firebaseFirestoreProvider).collection('barbers').where('__name__',whereIn: ids).get();
        return snap.docs.map((doc) => Barber.fromDocument(doc)).toList();
        //List<Barber> barbers= snap.docs.map((doc) => Barber.fromDocument(doc)).toList();
       // print(barbers.toString());
        //return barbers;
        // print(ids.toString());
        // List<Barber> barbers = [];
        // ids.forEach((id)async {
        //   print(id);
        //   Barber snap = await  _read(firebaseFirestoreProvider).collection('barbers').doc(id).get().then((value) => Barber.fromDocument(value));
        //   print("ez lesz a barber");
        //   print(snap.toString());
        //   barbers.add(snap);
        // });
        // print(barbers.toString());

        //return barbers;
    } on FirebaseException catch (e) {
        developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
        throw CustomException(message: e.message);
    }

  }
  Future<List<Barber>> retrieveBarbersFromShop2(String shopId) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop2] - Barbers retrieved from shop.");
    try {//EZ JÓ DE CSAK 10 IG MUKODIK
      final snap = await _read(firebaseFirestoreProvider).collection('barbers').where('barbershop_id', isEqualTo: shopId).get();
      retrieveAvailability('a');
      return snap.docs.map((doc) => Barber.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Availability>> retrieveAvailability(String barberId) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop2] - Barbers retrieved from shop.");
    try {
      //final snap = await _read(firebaseFirestoreProvider).collection('barbers').doc(barberId).collection('availability').get();
      final snap = await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc('8KyCYKVgBtKd6Rfec4ZD')
          .collection('availability')
          .where('__name__',isGreaterThanOrEqualTo: '2022-10-02')
          .get();
      print("itt kell nezni");print(snap.docs.toString());
      return snap.docs.map((doc) => Availability.fromDocumentCustom(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<WorkDayAvailability>> retrieveWorkDayAvailability(String barberId) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop2] - Barbers retrieved from shop.");
    try {
      //final snap = await _read(firebaseFirestoreProvider).collection('barbers').doc(barberId).collection('availability').get();
      final snap = await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc('8KyCYKVgBtKd6Rfec4ZD')
          .collection('work_day_availability')
          .where('__name__',isGreaterThanOrEqualTo: '2022-10-02')
          .get();
      print("itt kell nezni");print(snap.docs.toString());
      return snap.docs.map((doc) => WorkDayAvailability.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<void> updateBarber({required Barber barber}) async {
    developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Updateing Barber...");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc(barber.id)
          .update(barber.toDocument());
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Failure during Barber update.");
      throw CustomException(message: e.message);
    }
  }

  Future<void> updateWorkDayAvailability({required String barberId, required String appointmentId, required int newStart, required int newEnd}) async {
    developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Updating WokrDayAvailability...");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc(barberId)
          .collection('work_day_availability')
          .doc(appointmentId)
          .update({"start":newStart, "end":newEnd})
          .then((value) => developer.log("Working hour succesfully modified to start:${newStart} end: ${newEnd}"));
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Failure during Working hour update.");
      throw CustomException(message: e.message);
    }
  }

  Future<void> addWorkDayAvailability({required String barberId, required String appointmentId, required int start, required int end}) async {
    developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Adding WokrDayAvailability...");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc(barberId)
          .collection('work_day_availability')
          .doc(appointmentId)
          .set({"start":start, "end":end})
          .then((value) => developer.log("New availability successfully added to ${appointmentId} start:${start} end: ${end}"));
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Failure during adding Working hour update.");
      throw CustomException(message: e.message);
    }
  }

  Future<String> createItem({
    //required String userId,
    required Barber newBarber,
  }) async {
    developer.log("[itemrepository.dart][itemRepository][createItem] - Item created.");
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .add(newBarber.toDocument());
      final addToShop = await _read(firebaseFirestoreProvider)
          .collection('barbershops')
          .doc(newBarber.barbershop_id)
          .update({
              "barbers":FieldValue.arrayUnion([docRef.id])
           });

    
      //print(addToShop.get().then((value) => value['barbers']));
      return docRef.id;
      return "asd";
    } on FirebaseException catch (e) {
      developer.log("[itemrepository.dart][itemRepository][createItem] - Item create exception.");
      throw CustomException(message: e.message);
    }
  }

}
