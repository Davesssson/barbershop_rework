
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/extensions/firebase_firestore_extension.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repositories/barbershops_repository.dart';
import '../repositories/custom_exception.dart';
import 'dart:developer' as developer;

final filteredBarbershopSingleProvider = Provider.family<Barbershop,String>((ref,id) {
  developer.log("[barbershop_controller.dart][-][filteredBarbershopSingleProvider] - filteredBarbershopSingleProvider.");
  final itemListState = ref.watch(BarbershopSingleControllerProvider(id));
  return itemListState.maybeWhen(
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


final filteredBarbershopListProvider = Provider<List<Barbershop>>((ref) {
  developer.log("[barbershop_controller.dart][-][filteredBarbershopListProvider] - filteredBarbershopListProvider.");
  final itemListState = ref.watch(BarbershopListControllerProvider);
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




final BarbershopSingleControllerProvider = StateNotifierProvider.family<BarbershopSingleController, AsyncValue<Barbershop>,String>((ref,id) {
  developer.log("[barbershop_controller.dart][-][BarbershopSingleControllerProvider] - BarbershopSingleControllerProvider.");
  return BarbershopSingleController(ref.read,id);
},);



class BarbershopSingleController extends StateNotifier<AsyncValue<Barbershop>>{
  final Reader _read;
  final _id;

  BarbershopSingleController(this._read,this._id):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopSingleController][BarbershopSingleController] - BarbershopSingleController Constructed.");
    retrieveSingleBarbershop(_id);
  }

  Future<void> retrieveSingleBarbershop(String id,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopSingleController][retrieveSingleBarbershop] - retrieve Single barbershop .");
      final items = await _read(barbershopRepositoryProvider).retrieveSingleBarbershop(id);
      if (mounted) {

        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopSingleController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }
}


final BarbershopListControllerProvider = StateNotifierProvider<BarbershopListController, AsyncValue<List<Barbershop>>>((ref) {
  developer.log("[barbershop_controller.dart][-][BarbershopListControllerProvider] - BarbershopListControllerProvider.");
  return BarbershopListController(ref.read);
  },
);


class BarbershopListController extends StateNotifier<AsyncValue<List<Barbershop>>>{
  final Reader _read;
  BarbershopListController(this._read):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopListController][BarbershopListController] - BarbershopListController Constructed.");
    retrieveBarbershops();
  }

  BarbershopListController.masikconstructor(this._read,String id):super(AsyncValue.loading()){
    retrieveSingleBarbershop(id);
  }


  Future<void> retrieveBarbershops({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListController][retrieveBarbershops] - retrieveBarbershops .");
      final items = await _read(barbershopRepositoryProvider).retrieveBarbershops();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListController][retrieveBarbershops] - retrieveBarbershops Exception.");
      state = AsyncValue.error(e);
    }
  }
  Future<void> retrieveSingleBarbershop(String id,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopSingleController][retrieveSingleBarbershop] - retrieve Single barbershop .");
      final items = await _read(barbershopRepositoryProvider).retrieveSingleBarbershop(id);
      if (mounted) {
        List<Barbershop> asd = [];
        asd.add(items);
        state = AsyncValue.data(asd);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopSingleController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }


}


