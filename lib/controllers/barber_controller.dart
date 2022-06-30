import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/barber/barber_model.dart';
import '../repositories/barber_repository.dart';
import '../repositories/barbershops_repository.dart';
import '../repositories/custom_exception.dart';

final filteredBarberListProvider = Provider<List<Barber>>((ref) {
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
  return BarberListController(ref.read);
},);

class BarberListController extends StateNotifier<AsyncValue<List<Barber>>>{
  final Reader _read;
  BarberListController(this._read):super(AsyncValue.loading()){
    retrieveBarbers();
  }

  Future<void> retrieveBarbers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items = await _read(barberRepositoryProvider).retrieveBarbers();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveSingleBarber(String id, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items = await _read(barberRepositoryProvider).retrieveSingleBarbersFromShop(id);
      if (mounted) {
        List<Barber> asd=[]; asd.add(items);
        state = AsyncValue.data(asd);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveBarbersFromShop(List<String> ids, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items = await _read(barberRepositoryProvider).retrieveBarbersFromShop(ids);
      if (mounted) {

        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }


}