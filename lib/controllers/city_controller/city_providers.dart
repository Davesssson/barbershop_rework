import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import 'city_controller.dart';

final cityListFilterProvider = StateProvider<String>((_) => "");

final cityListContentProvider = Provider<List<String>>((ref) {
  developer.log("[city_providers.dart][-][cityListContentProvider] - cityListContentProvider.");
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
  developer.log("[city_providers.dart][-][cityListStateProvider] - cityListStateProvider");
  return CityListStateController(ref.read);
},
);