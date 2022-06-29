import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/models/item/item_model.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/repositories/item_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

enum ItemListFilter {
  all,
  obtained,
}

//ez csak megváltoztatja az enum állapotát
final itemListFilterProvider = StateProvider<ItemListFilter>((_) => ItemListFilter.all);

//ez adja vissza a szűrt és a nemszűrt listát is
final filteredItemListProvider = Provider<List<Item>>((ref) {
  //itt állítjuk be a szűrést
  final itemListFilterState = ref.watch(itemListFilterProvider);

  final itemListState = ref.watch(itemListControllerProvider);
  return itemListState.maybeWhen(
    data: (items) {
      switch (itemListFilterState) {
        case ItemListFilter.obtained:
          return items.where((item) => item.obtained).toList();
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
final itemListControllerProvider = StateNotifierProvider<ItemListController, AsyncValue<List<Item>>>((ref) {
    developer.log("[item_list_controller.dart][itemListControllerProvider] - StateNotifier invoked..");
    final user = ref.watch(authControllerProvider);
    //ami egyből fetchel is...
    return ItemListController(ref.read, user?.uid);
  },
);

//ez maga a facade, amin hívjuk a dolgokat. Ezen belül implementáljuk a végpontokat, amiket a user elér
class ItemListController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _read;
  final String? _userId;

  ItemListController(this._read, this._userId) : super(AsyncValue.loading()) {
    if (_userId != null) {
      retrieveItems();
    }
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items =
          await _read(itemRepositoryProvider).retrieveItems(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<void> addItem({required String name, bool obtained = false}) async {
    try {
      final item = Item(name: name, obtained: obtained);
      final itemId = await _read(itemRepositoryProvider).createItem(
        userId: _userId!,
        item: item,
      );
      state.whenData((items) =>
          state = AsyncValue.data(items..add(item.copyWith(id: itemId))));
    } on CustomException catch (e) {
      //_read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> updateItem({required Item updatedItem}) async {
    try {
      await _read(itemRepositoryProvider)
          .updateItem(userId: _userId!, item: updatedItem);
      state.whenData((items) {
        state = AsyncValue.data([
          for (final item in items)
            if (item.id == updatedItem.id) updatedItem else item
        ]);
      });
    } on CustomException catch (e) {
     // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> deleteItem({required String itemId}) async {
    try {
      await _read(itemRepositoryProvider).deleteItem(
        userId: _userId!,
        itemId: itemId,
      );
      state.whenData((items) => state =
          AsyncValue.data(items..removeWhere((item) => item.id == itemId)));
    } on CustomException catch (e) {
     // _read(itemListExceptionProvider).state = e;
    }
  }
}

final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);
