import 'package:flutter_shopping_list/controllers/city_controller/city_controller.dart';
import 'package:flutter_shopping_list/controllers/service_controller/service_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import '../../models/barbershop/barbershop_model.dart';
import '../city_controller/city_providers.dart';
import 'barbershop_controller.dart';

bool checkIfTagIsConteined(Barbershop b, ProviderRef<List<Barbershop>> ref){
  final serviceTagfFilterState = ref.read(serviceTagsFilterProvider);
  var bSet = b.tags!.toSet();
  final tSet = serviceTagfFilterState.toSet();
  if(bSet.intersection(tSet).toList().isNotEmpty)
    return true;
  else return false;
}

final barbershopListContentProvider = Provider<List<Barbershop>>((ref) {
  developer.log("[barbershop_providers.dart][-][barbershopListContentProvider] - barbershopListContentProvider.");
  final barbershopsListState = ref.watch(barbershopListStateProvider);
  final cityListFilterState = ref.watch(cityListFilterProvider);
  final serviceTagfFilterState = ref.watch(serviceTagsFilterProvider);

  return barbershopsListState.maybeWhen(
    data: (shops) {
      //if(cityListFilterState.toString()!="")
      //  return shops.where((shop) => shop.city==cityListFilterState.toString()).toList();
      print("serviceTagfFilterState toString");
      print(serviceTagfFilterState.toString());
      print("serviceTagfFilterState");
      print(serviceTagfFilterState);
      print("feltetel");
      print(serviceTagfFilterState.toString().isNotEmpty);
      if(serviceTagfFilterState.isNotEmpty) {
        print("itt vagyok");
        final asd =  shops.where((element) {
          var bSet = element.tags!.toSet(); // TODO Ide még kéne egy csekk, hogy fix legyen
          final tSet = serviceTagfFilterState.toSet();
          return checkIfTagIsConteined(element, ref);
        }).toList();
        print(asd);
        return asd;
        
      }else
        return shops;
    },
    orElse: () => [],
  );
});

final barbershopListStateProvider = StateNotifierProvider<BarbershopListStateController, AsyncValue<List<Barbershop>>>((ref) {
  developer.log("[barbershop_providers.dart][-][barbershopListStateProvider] - barbershopListStateProvider.");
  return BarbershopListStateController(ref.read);
  },
);