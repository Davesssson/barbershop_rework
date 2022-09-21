import 'dart:developer' as developer;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/riverpod.dart';
import '../../models/responses/marker_response_item.dart';
import '../city_controller/city_providers.dart';
import 'marker_controller.dart';

final markerListContentProvider = Provider<Set<Marker>>((ref) {
  developer.log("[marker_providers.dart][-][markerListContentProvider] - markerListContentProvider.");
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
  developer.log("[marker_providers.dart][-][markerListStateProvider] - markerListStateProvider");
  return MarkerListStateController(ref.read);
},
);