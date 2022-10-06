import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shopping_list/models/availability/availability_model.dart';
import 'package:flutter_shopping_list/repositories/barber_repository.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final availabilityProvider = FutureProvider<List<Availability>>((ref) async {
    final asd = await ref.read(barberRepositoryProvider).retrieveAvailability('barberId');
    print('providerben vagyok');
    print(asd.toString());
    return asd;
});
