
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