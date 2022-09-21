import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../repositories/custom_exception.dart';
import '../../repositories/service_repository.dart';

class ServiceListStateController extends StateNotifier<AsyncValue<List<String>>>{
  final Reader _read;
  ServiceListStateController(this._read):super(AsyncValue.loading()){
    retrieveServiceTags();
  }

  Future<void> retrieveServiceTags({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags ");
      final items = await _read(serviceRepositoryProvider).retrieveServiceTags();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags Exception");
      state = AsyncValue.error(e);
    }
  }
}