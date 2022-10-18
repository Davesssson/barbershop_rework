import 'dart:developer' as developer;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/riverpod.dart';
import '../../models/responses/marker_response_item.dart';
import '../../ui/map_screen/map_screen.dart';
import '../city_controller/city_providers.dart';
import 'marker_controller.dart';

final markerListContentProvider = Provider<Set<Marker>>((ref) {
  developer.log("[marker_providers.dart][-][markerListContentProvider] - markerListContentProvider.");
  final markersListState = ref.watch(markerListStateProvider);
  final cityListFilterState = ref.watch(cityListFilterProvider);

  return markersListState.maybeWhen(
    data: (markerItems) {
      //if(cityListFilterState.toString()!="") {
        return markerItems.where((element) => element.city==cityListFilterState.toString()).map((markerItem) {
          return Marker(
              onTap: (){
                print("cityFilterStateForMap state = " +ref.read(cityFilterStateForMap.notifier).state.toString());
                final sofar=ref.read(cityFilterStateForMap.notifier).state.toString();
                final wantToChangeTo = markerItem.marker!.markerId.toString();
                print("sofar" +sofar);
                print("want to change to"+wantToChangeTo);
                if(wantToChangeTo.contains("(")) {
                  final clean = wantToChangeTo.split("(")[1].split(")")[0];
                  ref.read(cityFilterStateForMap.notifier).state=clean;
                  return;
                }
                  print("MEGVAGY GECI");
                ref.read(cityFilterStateForMap.notifier).state=markerItem.marker!.markerId.toString();
                print("cityFilterStateForMap state = " +ref.read(cityFilterStateForMap.notifier).state.toString());

              },
              markerId: markerItem.marker!.markerId,
              position: markerItem.marker!.position
          );
        }).toSet();

      },/*else {
        return {
          Marker(markerId: MarkerId("asd"), position: LatLng(47.4512843, 19.08))
        };
      }},*/
    orElse: () => {},
  );
});


final markerListStateProvider = StateNotifierProvider<MarkerListStateController, AsyncValue<Set<MarkerResponseItem>>>((ref) {
  developer.log("[marker_providers.dart][-][markerListStateProvider] - markerListStateProvider");
  return MarkerListStateController(ref.read);
},
);