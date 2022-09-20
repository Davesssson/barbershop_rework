

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../repositories/custom_exception.dart';
import '../repositories/service_repository.dart';

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
  developer.log("[city_controller.dart][-][cityListStateProvider] - cityListStateProvider");
  return ServiceListStateController(ref.read);
},
);

class ServiceListStateController extends StateNotifier<AsyncValue<List<String>>>{
  final Reader _read;
  ServiceListStateController(this._read):super(AsyncValue.loading()){
    retrieveServiceTags();
  }

  Future<void> retrieveServiceTags({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities ");
      final items = await _read(serviceRepositoryProvider).retrieveServiceTags();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities Exception");
      state = AsyncValue.error(e);
    }
  }
}