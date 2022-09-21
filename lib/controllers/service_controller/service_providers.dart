import 'package:flutter_shopping_list/controllers/service_controller/service_controller.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;

final serviceTagsListProvider = Provider<List<String>>((ref){
  final serviceTagsState = ref.watch(serviceListStateProvider);
  return serviceTagsState.maybeWhen(
    data:(tags){
      return tags;
    } ,
    orElse: ()=> [],
  );
});

final serviceListStateProvider = StateNotifierProvider<ServiceListStateController, AsyncValue<List<String>>>((ref) {
  developer.log("[service_providers.dart][-][serviceListStateProvider] - serviceListStateProvider");
    return ServiceListStateController(ref.read);
  },
);