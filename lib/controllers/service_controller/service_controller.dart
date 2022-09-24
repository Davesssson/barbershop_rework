import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../models/service/service_model.dart';
import '../../repositories/custom_exception.dart';
import '../../repositories/service_repository.dart';

class ServiceListStateController extends StateNotifier<AsyncValue<List<Service>>>{
  final Reader _read;
  ServiceListStateController(this._read):super(AsyncValue.loading()){
    retrieveServiceTags();
  }

  Future<void> retrieveServiceTags({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags ");
      final items = await _read(serviceRepositoryProvider).retrieveServices();
      if (mounted) {
        state = AsyncValue.data(items);
        print("services state now = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags Exception");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveServiceTagsFromShop(String shopId,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags ");
      final items = await _read(serviceRepositoryProvider).retrieveServicesFromShop(shopId);
      if (mounted) {
        state = AsyncValue.data(items);
        print("services state now = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags Exception");
      state = AsyncValue.error(e);
    }
  }
}