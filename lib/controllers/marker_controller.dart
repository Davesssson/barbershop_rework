import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/controllers/city_controller.dart';
import 'package:flutter_shopping_list/models/responses/marker_response_item.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;


final markerListContentProvider = Provider<Set<Marker>>((ref) {
  developer.log("[barbershop_controller.dart][-][barbershopListContentProvider] - barbershopListContentProvider.");
  final markersListState = ref.watch(markerListStateProvider);
  final cityListFilterState = ref.watch(cityListFilterProvider);

  return markersListState.maybeWhen(
    data: (markerItems) {
      if(cityListFilterState.toString()!="") {
        return markerItems.where((element) => element.city==cityListFilterState.toString()).map((markerItem) {
          return Marker(
              markerId: markerItem.marker!.markerId,
              position: markerItem.marker!.position
          );
        }).toSet();

      }else {
        return {
          Marker(markerId: MarkerId("asd"), position: LatLng(47.4512843, 19.08))
        };
      }},
    orElse: () => {},
  );
});


final markerListStateProvider = StateNotifierProvider<MarkerListStateController, AsyncValue<Set<MarkerResponseItem>>>((ref) {
  developer.log("[marker_controller.dart][-][cityListStateProvider] - cityListStateProvider");
  return MarkerListStateController(ref.read);
},
);

class MarkerListStateController extends StateNotifier<AsyncValue<Set<MarkerResponseItem>>> {
  final Reader _read;

  MarkerListStateController(this._read) : super(AsyncValue.loading()) {
    developer.log("[marker_controller.dart][CityListStateController][CityListStateController] - CityListStateController constructed");
    retrieveCityMarkers();
  }

  Future<void> retrieveCityMarkers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[marker_controller.dart][CityListStateController][retrieveCities] - retrieveCities ");
      final city = await _read(cityListFilterProvider.state);
      final markers =await _read(barbershopRepositoryProvider).retrieveCityMarkers2();
      print("controller" + markers.toString());
      if (mounted) {
        state = AsyncValue.data(markers);
      }
    } on CustomException catch (e) {
      developer.log("[marker_controller.dart][CityListStateController][retrieveCities] - retrieveCities Exception");
      state = AsyncValue.error(e);
    }
  }
}


