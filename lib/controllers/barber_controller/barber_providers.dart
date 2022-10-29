
import 'package:flutter_shopping_list/repositories/barber_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import '../../models/barber/barber_model.dart';
import 'barber_controller.dart';

final barberListContentProvider = Provider<List<Barber>>((ref) {
  developer.log("[barber_providers.dart][-][barberListContentProvider] - barberListContentProvider.");
  final barbersListState = ref.watch(barberListStateProvider);
  return barbersListState.maybeWhen(
    data: (barbers) {
      switch ("asd") {
        default:
          return barbers;
      }
    },
    orElse: () => [],
  );
});


final retrieveBarbersWorks = FutureProvider.family<List<Barber>,String>((ref,shopId) async {
  final barbers = await ref.read(barberRepositoryProvider).retrieveBarbersFromShop2(shopId);
  print("barbers.tostring"+barbers.toString());
  return barbers;
});

final retrieveSingleBarber = FutureProvider.family<Barber,String>((ref,barberId) async {
  final barber = await ref.read(barberRepositoryProvider).retrieveSingleBarbersFromShop(barberId);
  print("barbers.tostring"+barber.toString());
  return barber;
});

final retrieveBookingsfrom = FutureProvider.family<List<Barber>,String>((ref,shopId) async {
  final barbers = await ref.read(barberRepositoryProvider).retrieveBarbersFromShop2(shopId);
  print("barbers.tostring"+barbers.toString());
  return barbers;
});

//ezt át lehetne írni úgy, hogy a barberListProviderből returnol egy listát, az alapján, hogy a shopId megegyezik e kért shoppal
final barberListForShopContentProvider = Provider<List<Barber>>((ref) {
  developer.log("[barber_providers.dart][-][barberListContentProvider] - barberListContentProvider.");
  final barbersListState = ref.watch(barberListForShopStateProvider);
  return barbersListState.maybeWhen(
    data: (barbers) {
      switch ("asd") {
        default:
          return barbers;
      }
    },
    orElse: () => [],
  );
});

final barberListStateProvider = StateNotifierProvider<BarberListStateController, AsyncValue<List<Barber>>>((ref) {
  developer.log("[barber_providers.dart][-][barberListStateProvider] - barberListStateProvider.");
  return BarberListStateController(ref.read);
},);

final barberListForShopStateProvider = StateNotifierProvider<BarberListStateController, AsyncValue<List<Barber>>>((ref) {
  developer.log("[barber_providers.dart][-][barberListStateProvider] - barberListStateProvider.");
  return BarberListStateController.forShop(ref.read);
},);