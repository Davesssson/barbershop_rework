import 'package:flutter_shopping_list/repositories/cities_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

import '../../models/city/city_model.dart';



class CityListStateController extends StateNotifier<AsyncValue<List<City>>> {
  final Reader _read;

/*  CityListStateController(this._read) : super(AsyncValue.loading()) {
      developer.log("[city_controller.dart][CityListStateController][CityListStateController] - CityListStateController constructed");
      retrieveCities();
  }*/

  CityListStateController.forModel(this._read) : super(AsyncValue.loading()) {
    developer.log("[city_controller.dart][CityListStateController][CityListStateController] - CityListStateController constructed");
    retrieveCities2();
  }

/*  Future<void> retrieveCities({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities ");
      final items = await _read(citiesRepositoryProvider).retrieveCities();
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().i("CityStateController state = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities Exception");
      state = AsyncValue.error(e);
    }
  }*/

  Future<void> retrieveCities2({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities ");
      final items = await _read(citiesRepositoryProvider).retrieveCities2();
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().i("CityStateController state = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities Exception");
      state = AsyncValue.error(e);
    }
  }
}

final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);
