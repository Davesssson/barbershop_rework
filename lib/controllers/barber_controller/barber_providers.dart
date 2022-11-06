import 'package:flutter_shopping_list/repositories/barber_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import '../../models/barber/barber_model.dart';
import 'barber_controller.dart';


final retrieveBarbersWorks = FutureProvider.family<List<Barber>,String>((ref,shopId) async {
  final barbers = await ref.read(barberRepositoryProvider).retrieveBarbersFromShop2(shopId);
  print("barbers.tostring"+barbers.toString());
  return barbers;
});


//region majd később
final retrieveSingleBarber = FutureProvider.family<Barber,String>((ref,barberId) async {
  final barber = await ref.read(barberRepositoryProvider).retrieveSingleBarbersFromShop(barberId);
  print("barbers.tostring"+barber.toString());
  return barber;
});
//endregion majd később

final barberListStateProvider = StateNotifierProvider<BarberListStateController, AsyncValue<List<Barber>>>((ref) {
  developer.log("[barber_providers.dart][-][barberListStateProvider] - barberListStateProvider.");
  return BarberListStateController(ref.read);
},);

final barberListForShopStateProvider = StateNotifierProvider.family<BarberListStateController, AsyncValue<List<Barber>>,String>((ref,id) {
  developer.log("[barber_providers.dart][-][barberListStateProvider] - barberListStateProvider.");
  return BarberListStateController.forShop(ref.read,id);
},);
