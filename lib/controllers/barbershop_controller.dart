import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/controllers/city_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repositories/barbershops_repository.dart';
import '../repositories/custom_exception.dart';
import 'dart:developer' as developer;

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

class BarbershopListStateController extends StateNotifier<AsyncValue<List<Barbershop>>>{
  final Reader _read;
  BarbershopListStateController(this._read):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopListStateController][BarbershopListStateController] - BarbershopListStateController Constructed.");
    retrieveBarbershops();
  }

  Future<void> retrieveBarbershops({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops .");
      final items = await _read(barbershopRepositoryProvider).retrieveBarbershops();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops Exception.");
      state = AsyncValue.error(e);
    }
  }


  Future<void> retrieveSingleBarbershop(String id,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveSingleBarbershop] - retrieve Single barbershop .");
      final items = await _read(barbershopRepositoryProvider).retrieveSingleBarbershop(id);
      if (mounted) {
        List<Barbershop> asd = [];
        asd.add(items);
        state = AsyncValue.data(asd);
        //state = AsyncValue.data(List.from(items as List<Barbershop>)); //ez valamiért nem működik :(
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }


}


