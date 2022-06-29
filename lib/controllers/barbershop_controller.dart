import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repositories/barbershops_repository.dart';
import '../repositories/custom_exception.dart';


final filteredBarbershopListProvider = Provider<List<Barbershop>>((ref) {
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
  return BarbershopListController(ref.read);
},);

class BarbershopListController extends StateNotifier<AsyncValue<List<Barbershop>>>{
  final Reader _read;
  BarbershopListController(this._read):super(AsyncValue.loading()){
    retrieveBarbershops();
  }

  Future<void> retrieveBarbershops({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items = await _read(barbershopRepositoryProvider).retrieveBarbershops();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }
}