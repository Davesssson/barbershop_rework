import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repositories/barbershops_repository.dart';
import '../repositories/custom_exception.dart';
import 'dart:developer' as developer;

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


final BarbershopListControllerProvider = StateNotifierProvider<BarbershopListController, AsyncValue<List<Barbershop>>>((ref) {
  developer.log("[barbershop_controller.dart][-][BarbershopListControllerProvider] - BarbershopListControllerProvider.");
  return BarbershopListController(ref.read);
},);

class BarbershopListController extends StateNotifier<AsyncValue<List<Barbershop>>>{
  final Reader _read;
  BarbershopListController(this._read):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopListController][BarbershopListController] - BarbershopListController Constructed.");
    retrieveBarbershops();
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
}