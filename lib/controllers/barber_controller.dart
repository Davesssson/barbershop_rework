import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/barber/barber_model.dart';
import '../repositories/barber_repository.dart';
import '../repositories/custom_exception.dart';
import 'dart:developer' as developer;


final filteredBarberListFromShopProvider = Provider.family<List<Barber>,List<String>>((ref,ids) {
  print("filteredBarberListFromShopProvider kapott ids = ");
  print(ids);
  developer.log("[barber_controller.dart][-][filteredBarberListFromShopProvider] - filteredBarberListFromShopProvider.");
  final itemListState = ref.watch(BarberListControllerFromShopProvider(ids));
  return itemListState.maybeWhen(
    data: (items) {
      switch ("asd") {

        default:
          print("switch default ag");
          print(items);
          return items;
      }
    },
    orElse: () => [],
  );
});

final BarberListControllerFromShopProvider = StateNotifierProvider.family<BarberListFromShopController, AsyncValue<List<Barber>>,List<String>>((ref,ids) {
  developer.log("[barber_controller.dart][-][BarberListControllerFromShopProvider] - BarberListControllerFromShopProvider.");
  return BarberListFromShopController(ref.read,ids);
},);

class BarberListFromShopController extends StateNotifier<AsyncValue<List<Barber>>>{
  final Reader _read;
  BarberListFromShopController(this._read,List<String> ids):super(AsyncValue.loading()){
    developer.log("[barber_controller.dart][BarberListFromShopController][BarberListFromShopControllerConstructor] - BarberListFromShopController constructed.");
    retrieveBarbersFromShop(ids);
  }

  Future<void> retrieveBarbers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListFromShopController][retrieveBarbers] - retrieveBarbers.");
      final items = await _read(barberRepositoryProvider).retrieveBarbers();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbers] - retrieveBarbers Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveSingleBarber(String id, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListController][retrieveSingleBarber] - retrieveSingleBarber.");
      final items = await _read(barberRepositoryProvider).retrieveSingleBarbersFromShop(id);
      if (mounted) {
        List<Barber> asd=[]; asd.add(items);
        state = AsyncValue.data(asd);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListController][retrieveSingleBarber] - retrieveSingleBarber Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveBarbersFromShop(List<String> ids, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbersFromShop] - retrieveBarbersFromShop.");
      final items = await _read(barberRepositoryProvider).retrieveBarbersFromShop(ids);
      if (mounted) {
        print("state before =");
        print(state);
        state = AsyncValue.data(items);
        print("state after = ");
        print(state);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbersFromShop] - retrieveBarbersFromShop Exception.");
      state = AsyncValue.error(e);
    }
  }


}



//----------------------------------------------





final filteredBarberListProvider = Provider<List<Barber>>((ref) {
  developer.log("[barber_controller.dart][-][filteredBarberListProvider] - filteredBarberListProvider.");
  final itemListState = ref.watch(BarberListControllerProvider);
  return itemListState.maybeWhen(
    data: (items) {
      //switch (itemListFilterState) {
      switch ("asd") {
      //case ItemListFilter.obtained:
      //return items.where((item) => item.obtained).toList();
        default:
          return items;
      }
    },
    orElse: () => [],
  );
});

final BarberListControllerProvider = StateNotifierProvider<BarberListController, AsyncValue<List<Barber>>>((ref) {
  developer.log("[barber_controller.dart][-][BarberListControllerProvider] - BarberListControllerProvider.");
  return BarberListController(ref.read);
},);

class BarberListController extends StateNotifier<AsyncValue<List<Barber>>>{
  final Reader _read;
  BarberListController(this._read):super(AsyncValue.loading()){
    developer.log("[barber_controller.dart][BarberListController][BarberListControllerConstructor] - BarberListController constructed.");
    retrieveBarbers();
  }

  Future<void> retrieveBarbers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbers] - retrieveBarbers.");
      final items = await _read(barberRepositoryProvider).retrieveBarbers();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbers] - retrieveBarbers Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveSingleBarber(String id, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListController][retrieveSingleBarber] - retrieveSingleBarber.");
      final items = await _read(barberRepositoryProvider).retrieveSingleBarbersFromShop(id);
      if (mounted) {
        List<Barber> asd=[]; asd.add(items);
        state = AsyncValue.data(asd);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListController][retrieveSingleBarber] - retrieveSingleBarber Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveBarbersFromShop(List<String> ids, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbersFromShop] - retrieveBarbersFromShop.");
      final items = await _read(barberRepositoryProvider).retrieveBarbersFromShop(ids);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListController][retrieveBarbersFromShop] - retrieveBarbersFromShop Exception.");
      state = AsyncValue.error(e);
    }
  }


}