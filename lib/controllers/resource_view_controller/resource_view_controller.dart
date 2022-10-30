import 'package:flutter_shopping_list/models/resource_view_model/resource_view_model.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../repositories/barber_repository.dart';
import '../../repositories/custom_exception.dart';
import 'dart:developer' as developer;


class ResourceViewListStateController extends StateNotifier<AsyncValue<List<ResourceViewModel>>>{
  final Reader _read;
  ResourceViewListStateController(this._read,String shopId):super(AsyncValue.loading()){
    developer.log("[resource_view_controller.dart][ResourceViewListStateController][retrieveResourceViews] - ResourceViewListStateController constructed .");
    retrieveResourceViews(shopId);
  }


  Future<void> retrieveResourceViews(String shopId,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[resource_view_controller.dart][ResourceViewListStateController][retrieveResourceViews] - retrieve retrieveResourceViews .");
      final items = await _read(barberRepositoryProvider).retrieveResourceView(shopId);
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().i("RespurceViewController state = "+state.toString());
      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }
/*  //TODO
  Future<void> updateAvailabilityInState(String barberId,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[resource_view_controller.dart][ResourceViewListStateController][retrieveResourceViews] -  updateAvailabilityInState .");
      final items = await _read(barberRepositoryProvider).retrieveResourceView();
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().i("RespurceViewController state = "+state.toString());

      }
    } on CustomException catch (e) {
      state = AsyncValue.error(e);
    }
  }*/


}

