import 'package:flutter_shopping_list/models/resource_view_model/resource_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../repositories/barber_repository.dart';
import '../../repositories/custom_exception.dart';
import 'dart:developer' as developer;


class ResourceViewListStateController extends StateNotifier<AsyncValue<List<ResourceViewModel>>>{
  final Reader _read;
  ResourceViewListStateController(this._read):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopListStateController][BarbershopListStateController] - BarbershopListStateController Constructed.");
    retrieveResourceViews();
  }


  Future<void> retrieveResourceViews({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops .");
      final items = await _read(barberRepositoryProvider).retrieveResourceView();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops Exception.");
      state = AsyncValue.error(e);
    }
  }
  //TODO
  Future<void> updateAvailabilityInState(String barberId,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops .");
      final items = await _read(barberRepositoryProvider).retrieveResourceView();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops Exception.");
      state = AsyncValue.error(e);
    }
  }


}

