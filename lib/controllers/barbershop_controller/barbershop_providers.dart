
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import '../../models/barbershop/barbershop_model.dart';
import '../city_controller.dart';
import 'barbershop_controller.dart';

final barbershopListContentProvider = Provider<List<Barbershop>>((ref) {
  developer.log("[barbershop_controller.dart][-][barbershopListContentProvider] - barbershopListContentProvider.");
  final barbershopsListState = ref.watch(barbershopListStateProvider);
  final cityListFilterState = ref.watch(cityListFilterProvider);

  return barbershopsListState.maybeWhen(
    data: (shops) {
      if(cityListFilterState.toString()!="")
        return shops.where((shop) => shop.city==cityListFilterState.toString()).toList();
      else
        return shops;
    },
    orElse: () => [],
  );
});

final barbershopListStateProvider = StateNotifierProvider<BarbershopListStateController, AsyncValue<List<Barbershop>>>((ref) {
  developer.log("[barbershop_controller.dart][-][barbershopListStateProvider] - barbershopListStateProvider.");
  return BarbershopListStateController(ref.read);
  },
);