import 'package:flutter_shopping_list/controllers/service_controller/service_controller.dart';
import 'package:flutter_shopping_list/repositories/service_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;

import '../../models/service/service_model.dart';


final serviceTagsProvider = FutureProvider<List<String>>((ref) async {
  return await ref.read(serviceRepositoryProvider).retrieveServiceTags();
});

final serviceTagsFilterProvider = StateProvider<List<String>>((_) => []);

final serviceListForShopContentProvider = Provider<List<Service>>((ref){
  final serviceTagsState = ref.watch(serviceListForShopStateProvider);
  return serviceTagsState.maybeWhen(
    data:(tags){
      return tags;
    } ,
    orElse: ()=> [],
  );
});

final serviceListContentProvider = Provider<List<Service>>((ref){
  final serviceTagsState = ref.watch(serviceListStateProvider);
  return serviceTagsState.maybeWhen(
    data:(tags){
      return tags;
    } ,
    orElse: ()=> [],
  );
});

final serviceListStateProvider = StateNotifierProvider<ServiceListStateController, AsyncValue<List<Service>>>((ref) {
  developer.log("[service_providers.dart][-][serviceListStateProvider] - serviceListStateProvider");
    return ServiceListStateController(ref.read);
  },
);

final serviceListForShopStateProvider = StateNotifierProvider<ServiceListStateController, AsyncValue<List<Service>>>((ref) {
  developer.log("[service_providers.dart][-][serviceListStateProvider] - serviceListStateProvider");
  return ServiceListStateController.forShop(ref.read);
},
);