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
    developer.log("[service_repository.dart][ServiceRepository][retrieveServiceTags] - Retrieving serviceTags. . .");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('serviceTags').get();
      snap.docs.forEach((doc) {
        print(doc.id.toString());
      });
      final serviceTags =  snap.docs.map((doc) => doc.id.toString()).toList();;
      return serviceTags;
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving serviceTags");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Service>> retrieveServices()async {
    developer.log("[service_repository.dart][ServiceRepository][retrieveServices] - Retrieving Services. . .");
    try {
      final snap = await _read(firebaseFirestoreProvider).collection('services').get();
      snap.docs.forEach((doc) {
        print(doc.id.toString());
      });
      final services =  snap.docs.map((doc) => Service.fromDocument(doc)).toList();
      return services;
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving services.");
      throw CustomException(message: e.message);
    }
  }

  Future<List<Service>> retrieveServicesFromShop(String shopId) async{
    developer.log("[service_repository.dart][ServiceRepository][retrieveServicesFromShop] - Retrieving services for shop.");
    try {//EZ JÓ DE CSAK 10 IG MUKODIK
      final snap = await _read(firebaseFirestoreProvider).collection('services').where('barbershop_id', isEqualTo: shopId).get();
      return snap.docs.map((doc) => Service.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving barbers");
      throw CustomException(message: e.message);
    }
  }
  Future<void> updateService({required String serviceId,required Service service}) async{
    developer.log("[service_repository.dart][ServiceRepository][updateService] - updateService.");
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('services')
          .doc(serviceId)
          .update(service.toDocument());

    } on FirebaseException catch (e) {
      developer.log("Failure during retrieving barbers");
      throw CustomException(message: e.message);
    }
  }

  Future<String> createItem({
    required String shopId,
    required Service service,
  }) async {
    developer.log("[service_repository.dart][ServiceRepository][createItem] - Item created.");
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('services')
          .add(service.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      developer.log("[service_repository.dart][ServiceRepository][createItem] - Item create exception.");
      throw CustomException(message: e.message);
    }
  }

  Future<void> deleteService({
    required String serviceId,
  }) async {
    developer.log("[service_repository.dart][ServiceRepository][deleteService] - Item deleted");
    try {
      await _read(firebaseFirestoreProvider)
          .collection('services')
          .doc(serviceId)
          .delete();
    } on FirebaseException catch (e) {
      developer.log("[service_repository.dart][ServiceRepository][deleteService] - Delete item exception");
      throw CustomException(message: e.message);
    }
  }

  Future<Service> retrieveSingleService({
    required String serviceId,
  }) async {
    developer.log("[service_repository.dart][ServiceRepository][deleteService] - Get Single service");
    try {
      return await _read(firebaseFirestoreProvider)
          .collection('services')
          .doc(serviceId).get().then((value) => Service.fromDocument(value));
    } on FirebaseException catch (e) {
      developer.log("[service_repository.dart][ServiceRepository][deleteService] - Get single Service exception");
      throw CustomException(message: e.message);
    }
  }


}
