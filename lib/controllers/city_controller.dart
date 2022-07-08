import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/models/item/item_model.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/repositories/item_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

enum CityListFilter {
  all,
  choosen
}

//ez csak megváltoztatja az enum állapotát
final cityListFilterProvider = StateProvider<CityListFilter>((_) => CityListFilter.all);

//ez adja vissza a szűrt és a nemszűrt listát is
final filteredCityListProvider = Provider<List<String>>((ref) {
  developer.log("[item_list_controller.dart][-][filteredItemListProvider] - filteredItemListProvider.");
  //itt állítjuk be a szűrést
  final itemListFilterState = ref.watch(cityListFilterProvider);
  final itemListState = ref.watch(cityListControllerProvider);
  return itemListState.maybeWhen(
    data: (items) {
      switch (itemListFilterState) {
        //case CityListFilter.choosen:
        //  return items.where((item) => item.obtained).toList();
        default:
          return items;
      }
    },
    orElse: () => [],
  );
});

//todo | ez csak egy állapotot ad vissza!!, és magát a controllert.
//TODO | ezt olvasva meghívhatjuk rajta a metódusokat, amiket lentebb implementáltunk. Használat
//TODO | ref.read(itemListControllerProvider.notifier).METHODNAME
final cityListControllerProvider = StateNotifierProvider<cityListController, AsyncValue<List<String>>>((ref) {
  developer.log("[item_list_controller.dart][-][filteredItemListProvider] - StateNotifier invoked...");
  final user = ref.watch(authControllerProvider);
  //ami egyből fetchel is...
  return cityListController(ref.read, user?.uid);
},
);

//ez maga a facade, amin hívjuk a dolgokat. Ezen belül implementáljuk a végpontokat, amiket a user elér
class cityListController extends StateNotifier<AsyncValue<List<String>>> {
  final Reader _read;
  final String? _userId;

  cityListController(this._read, this._userId) : super(AsyncValue.loading()) {
    if (_userId != null) {
      developer.log("[item_list_controller.dart][ItemListController][ItemListControllerConstructor] - ItemListController constructed");
      retrieveCityes();
    }
  }

  Future<void> retrieveCityes({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[item_list_controller.dart][ItemListController][retrieveItems] - retrieveItems ");
      final items = await _read(barbershopRepositoryProvider).retrieveCityes();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[item_list_controller.dart][ItemListController][retrieveItems] - retrieveItems Exception");
      state = AsyncValue.error(e);
    }
  }
}

final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);
