import 'package:flutter_shopping_list/models/responses/marker_response_item.dart';
import 'package:flutter_shopping_list/repositories/cities_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

class MarkerListStateController extends StateNotifier<AsyncValue<Set<MarkerResponseItem>>> {
  final Reader _read;

  MarkerListStateController(this._read) : super(AsyncValue.loading()) {
    developer.log("[marker_controller.dart][MarkerListStateController][MarkerListStateController] - MarkerListStateController constructed");
    retrieveCityMarkers();
  }

  Future<void> retrieveCityMarkers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[marker_controller.dart][MarkerListStateController][retrieveCityMarkers] - retrieveMarkers ");
      final markers =await _read(citiesRepositoryProvider).retrieveCityMarkers2();
      if (mounted) {
        state = AsyncValue.data(markers);
        MyLogger.singleton.logger().i("MarkerController state =" + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[marker_controller.dart][MarkerListStateController][retrieveCityMarkers] - retrieveMarkers Exception");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveCityMarkersGeoQuery(LatLng middlePoint,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[marker_controller.dart][MarkerListStateController][retrieveCityMarkers] - retrieveMarkers ");
      final markers =await _read(citiesRepositoryProvider).retrieveCityMarkersGeoLocation2(middlePoint);
      if (mounted) {
        state = AsyncValue.data(markers);
        MyLogger.singleton.logger().i("MarkerController state =" + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[marker_controller.dart][MarkerListStateController][retrieveCityMarkers] - retrieveMarkers Exception");
      state = AsyncValue.error(e);
    }
  }
}


