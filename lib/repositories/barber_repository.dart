import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/availability/availability_model.dart';
import 'package:flutter_shopping_list/models/resource_view_model/resource_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import '../models/barber/barber_model.dart';
import '../models/booking/booking_day_model.dart';
import '../models/booking/booking_model.dart';
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
    developer.log("[barber_repository.dart][BarberRepository][retrieveWorkDayAvailability] - Barbers Work day availability retrieved.");
    try {
      //final snap = await _read(firebaseFirestoreProvider).collection('barbers').doc(barberId).collection('availability').get();
      final snap = await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc(barberId)
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

  Future<void> addBooking({required String barberId, required String dateId, required int start, required String uId}) async {
    developer.log("[barber_repository.dart][BarberRepository][updateBarber] - Adding WokrDayAvailability...");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc(barberId)
          .collection('bookings')
          .doc(dateId)
          .set({uId:{"barberId":barberId, "dateId":dateId,"start":start,"end":start+30,"uId":uId}})
          .then((value) => developer.log("New availability successfully added to ${dateId} start:${start} end: "));
    } on FirebaseException catch (e) {
      //nem tudja azt kezelni, hogyha updatelni akarunk egy olyan dokumentumot, ami nem létezik
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

  Future<List<BookingDay>> retrieveBookings(String barberId) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveWorkDayAvailability] - Barbers Booking retrieved.");
    try {
      //final snap = await _read(firebaseFirestoreProvider).collection('barbers').doc(barberId).collection('availability').get();
      final snap = await _read(firebaseFirestoreProvider)
          .collection('barbers')
          .doc(barberId)
          .collection('bookings')
          .where('__name__',isGreaterThanOrEqualTo: '2022-10-02')
          .get();
      print("itt kell nezni");print(snap.docs.toString());
       return snap.docs.map((doc) => BookingDay.fromDocumentCustom(doc)).toList();
      //return snap.docs.map((doc) => Booking.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers booking retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<ResourceViewModel>> retrieveResourceView() async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveWorkDayAvailability] - Barbers Work day availability retrieved.");
    try {
      //final snap = await _read(firebaseFirestoreProvider).collection('barbers').doc(barberId).collection('availability').get();

      List<Barber> barbers =  await retrieveBarbersFromShop2('7HTJ8DF8hFwUnrL566Wc');

      List<Future<List<WorkDayAvailability>>> list_workday= barbers.map((barber)  {
        return  retrieveWorkDayAvailability(barber.id!);
      }).toList();

      List<Future<List<BookingDay>>> list_bookings= barbers.map((barber)  {
        return  retrieveBookings(barber.id!);
      }).toList();

      final result_availability = await Future.wait(list_workday);
      final result_booking = await Future.wait(list_bookings);

      final List<ResourceViewModel> resViewresult =[];
      for(int i=0; i<result_availability.length;i++){
        final item = ResourceViewModel(
          barber: barbers[i],
          workDayAvailability: result_availability[i],
          bookings: result_booking[i]
        );
        resViewresult.add(item);
      }
      print("mukodjel kerlek" + resViewresult.toString());
      return resViewresult;
      //return asd
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }

}
