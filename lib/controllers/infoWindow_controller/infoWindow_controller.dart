import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/repositories/cities_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

import '../../repositories/barbershops_repository.dart';



class infoWindowController extends StateNotifier<AsyncValue<Barbershop>> {
  final Reader _read;

  infoWindowController(this._read,String shopId) : super(AsyncValue.loading()) {
    developer.log("[city_controller.dart][CityListStateController][CityListStateController] - CityListStateController constructed");
    retrieveBarbershop(shopId);
  }

  Future<void> retrieveBarbershop(String shopId,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities ");
      final items = await _read(barbershopRepositoryProvider).retrieveSingleBarbershop(shopId);
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[city_controller.dart][CityListStateController][retrieveCities] - retrieveCities Exception");
      state = AsyncValue.error(e);
    }
  }
}

final itemListExceptionProvider = StateProvider<CustomException?>((_) => null);
