

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer ;

import '../general_providers.dart';
import '../models/service/service_model.dart';
import 'custom_exception.dart';
abstract class BaseServiceRepository {
  Future<List<String>> retrieveServiceTags();
}

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) => ServiceRepository(ref.read));

class ServiceRepository implements BaseServiceRepository{
  final Reader _read;

  const ServiceRepository(this._read);

  @override
  Future<List<String>> retrieveServiceTags()async {
    developer.log("[service_repository.dart][ServiceRepository][retrieveServiceTags] - retrieveServiceTags retrieved.");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('serviceTags').get();
      print("snap");
      snap.docs.forEach((doc) {
        print(doc.id.toString());
      });
      //final serviceTags =  snap.docs.map((doc) => doc.toString()).toList();
      final serviceTags =  snap.docs.map((doc) => doc.id.toString()).toList();;
      developer.log("[serviceTags = " + serviceTags.toString());
      return serviceTags;
    } on FirebaseException catch (e) {
      developer.log("[service_repository.dart][ServiceRepository][retrieveServiceTags] - retrieveServiceTags retrieved exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Service>> retrieveServices()async {
    developer.log("[service_repository.dart][ServiceRepository][retrieveServices] - retrieveServices retrieved.");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('services').get();
      print("snap");
      snap.docs.forEach((doc) {
        print(doc.id.toString());
      });
      //final serviceTags =  snap.docs.map((doc) => doc.toString()).toList();
      //final serviceTags =  snap.docs.map((doc) => doc.id.toString()).toList();;
      final services =  snap.docs.map((doc) => Service.fromDocument(doc)).toList();
      developer.log("[serviceTags = " + services.toString());
      return services;
    } on FirebaseException catch (e) {
      developer.log("[service_repository.dart][ServiceRepository][retrieveServiceTags] - retrieveServiceTags retrieved exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Service>> retrieveServicesFromShop(String shopId) async{
    developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop2] - Barbers retrieved from shop.");
    try {//EZ JÓ DE CSAK 10 IG MUKODIK
      final snap = await _read(firebaseFirestoreProvider).collection('services').where('barbershop_id', isEqualTo: shopId).get();
      return snap.docs.map((doc) => Service.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("[barber_repository.dart][BarberRepository][retrieveBarbersFromShop] - Barbers retrieve exception.");
      throw CustomException(message: e.message);
    }
  }
}
