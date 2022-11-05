import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../repositories/barbershops_repository.dart';
import '../../repositories/custom_exception.dart';
import 'dart:developer' as developer;

import '../marker_controller/marker_providers.dart';

final barbershopGeoqueryProvider = StreamProvider<List<Barbershop>>((ref) {
  final r = ref.watch(radius);
  final city = ref.watch(cityprovider);
  final center = ref.watch(locationProvider).location;
  print(r.toString());
  print(city.toString());
  print(center.toString());
  return ref.read(barbershopRepositoryProvider).retrieveBarbershopsGeoLocation2( LatLng(center!.latitude,center.longitude), r,city: city);
});

class BarbershopListStateController extends StateNotifier<AsyncValue<List<Barbershop>>>{
  final Reader _read;
  BarbershopListStateController(this._read):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopListStateController][BarbershopListStateController] - BarbershopListStateController Constructed.");
    retrieveBarbershops();
  }

  BarbershopListStateController.featured(this._read):super(AsyncValue.loading()){
    developer.log("[barbershop_controller.dart][BarbershopListStateController][BarbershopListStateController] - BarbershopListStateController Constructed.");
    retrieveFeaturedBarbershops();
  }

  Future<void> retrieveBarbershops({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops .");
      final items = await _read(barbershopRepositoryProvider).retrieveBarbershops();
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().d("Barbershop state = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveBarbershops] - retrieveBarbershops Exception.");
      state = AsyncValue.error(e);
    }
  }


  Future<void> retrieveSingleBarbershop(String id,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveSingleBarbershop] - retrieve Single barbershop .");
      final items = await _read(barbershopRepositoryProvider).retrieveSingleBarbershop(id);
      if (mounted) {
        List<Barbershop> asd = [];
        asd.add(items);
        state = AsyncValue.data(asd);
        MyLogger.singleton.logger().d("Barbershop state = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveFeaturedBarbershops({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveFeaturedBarbershops] -  retrieveFeaturedBarbershops .");
      final items = await _read(barbershopRepositoryProvider).retrieveFeaturedBarbershops();
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().d("Barbershop state = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[barbershop_controller.dart][BarbershopListStateController][retrieveSingleBarbershop] - retrieveSingleBarbershop Exception.");
      state = AsyncValue.error(e);
    }
  }


}


