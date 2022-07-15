import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../general_providers.dart';



final queryStateProvider = StateNotifierProvider<queryStateController, Query>((ref) {
  developer.log("[city_controller.dart][-][cityListStateProvider] - cityListStateProvider");
  final user = ref.watch(authControllerProvider);
  return queryStateController(ref.read, user?.uid);
},
);

class queryStateController extends StateNotifier<Query> {
  final Reader _read;
  final String? _userId;

  queryStateController(this._read, this._userId) : super(_read(firebaseFirestoreProvider).collection('barbershops')) {
     // retrieveCities();
  }

  void queryForCity(String city){
    state = _read(firebaseFirestoreProvider).collection('barbershops').where("city",isEqualTo: city);
  }
}





final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);
