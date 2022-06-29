import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../general_providers.dart';
import 'custom_exception.dart';
import 'dart:developer' as developer;

abstract class BaseBarbershopRepository {
  Future<List<Barbershop>> retrieveBarbershops();
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

}

