
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/controllers/city_controller.dart';
import 'package:flutter_shopping_list/extensions/firebase_firestore_extension.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repositories/barbershops_repository.dart';
import '../repositories/custom_exception.dart';
import 'dart:developer' as developer;

final barbershopSingleContentProvider = Provider.family<Barbershop,String>((ref,id) {
  developer.log("[barbershop_controller.dart][-][filteredBarbershopSingleProvider] - filteredBarbershopSingleProvider.");
  final barbershopsListState = ref.watch(barbershopSingleStateProvider(id));
  return barbershopsListState.maybeWhen(
    data: (items) {
      developer.log(items.toString());
      return items;
    },
    orElse: (){
      GeoPoint gp = GeoPoint(1,1);
      return Barbershop(location:gp); //NEKED A KURVA ANYÁDAT
    }
  );
});

// final filteredBarbershopListProvider2 = Provider<List<Barbershop>>((ref) {
//   developer.log("[barbershop_controller.dart][-][filteredBarbershopListProvider] - filteredBarbershopListProvider.");
//   final itemListState = ref.watch(BarbershopListControllerProvider);
//   final cityListFilterState = ref.watch(cityListFilterProvider);
//   return itemListState.maybeWhen(
//     data: (shops) {
//       //switch (itemListFilterState) {
//       switch (cityListFilterState) {
//         case cityListFilterState=="Budapest":
//           return shops.where((shop) => shop.city=="Budapest").toList();
//         default:
//           return shops;
//       }
//     },
//     orElse: () => [],
//   );
// });

final barbershopSingleStateProvider = StateNotifierProvider.family<BarbershopSingleStateController, AsyncValue<Barbershop>,String>((ref,id) {
  developer.log("[barbershop_controller.dart][-][barbershopSingleStateProvider] - barbershopSingleStateProvider.");
  return BarbershopSingleStateController(ref.read,id);
},);

class BarbershopSingleStateController extends StateNotifier<AsyncValue<Barbershop>>{
  final Reader _read;
  final _id;

  BarbershopSingleStateController(this._read,this._id):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopSingleStateController][BarbershopSingleStateController] - BarbershopSingleStateController Constructed.");
    retrieveSingleBarbershop(_id);
  }

  Future<void> retrieveSingleBarbershop(String id,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopSingleStateController][retrieveSingleBarbershop] - retrieve Single barbershop .");
      final item = await _read(barbershopRepositoryProvider).retrieveSingleBarbershop(id);
      if (mounted) {
        state = AsyncValue.data(item);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopSingleStateController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }
}




final barbershopListContentProvider = Provider<List<Barbershop>>((ref) {
  developer.log("[barbershop_controller.dart][-][barbershopListContentProvider] - barbershopListContentProvider.");
  final barbershopsListState = ref.watch(barbershopListStateProvider);
  final cityListFilterState = ref.watch(cityListFilterProvider);

  return barbershopsListState.maybeWhen(
    data: (shops) {
      //switch (itemListFilterState) {
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

  BarbershopListStateController.masikconstructor(this._read,String id):super(AsyncValue.loading()){
    retrieveSingleBarbershop(id);
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
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }


}


