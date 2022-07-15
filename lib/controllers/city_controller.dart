import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

final chipListFilterProvider = StateProvider<List<String>>((_) => []);

final cityListFilterProvider = StateProvider<String>((_) => "Budapest");



final cityListContentProvider = Provider<List<String>>((ref) {
  developer.log("[city_controller.dart][-][cityListContentProvider] - cityListContentProvider.");
  final itemListFilterState = ref.watch(cityListFilterProvider);
  final itemListState = ref.watch(cityListStateProvider);
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

final cityListStateProvider = StateNotifierProvider<CityListStateController, AsyncValue<List<String>>>((ref) {
  developer.log("[city_controller.dart][-][cityListStateProvider] - cityListStateProvider");
  final user = ref.watch(authControllerProvider);
  return CityListStateController(ref.read, user?.uid);
},
);

class CityListStateController extends StateNotifier<AsyncValue<List<String>>> {
  final Reader _read;
  final String? _userId;

  CityListStateController(this._read, this._userId) : super(AsyncValue.loading()) {
    if (_userId != null) {
      developer.log("[city_controller.dart][CityListStateController][CityListStateController] - CityListStateController constructed");
      retrieveCities();
    }
  }

  Future<void> retrieveCities({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities ");
      final items = await _read(barbershopRepositoryProvider).retrieveCities();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities Exception");
      state = AsyncValue.error(e);
    }
  }
}





final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);
