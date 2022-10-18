import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../controllers/city_controller/city_providers.dart';
import '../../controllers/item_list_controller.dart';
import '../../controllers/marker_controller/marker_providers.dart';
import '../../models/barbershop/barbershop_model.dart';
import 'info_window.dart';

//https://blog.bal.al/how-to-fix-cors-error-for-your-flutter-web-app
//https://github.com/themaaz32/auto_complete/blob/main/lib/main.dart
//https://pub.dev/packages/google_maps_cluster_manager

final cityFilterStateForMap = StateProvider<String>((_) => "");

class MapScreen extends ConsumerWidget {
  final _controller = Completer();
  Location location = Location();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(47.2475177, 19.1855499),
    zoom: 8.25,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionsState = ref.watch(cityListStateProvider);
    final markersState = ref.watch(markerListStateProvider);
    final markersContent = ref.watch(markerListContentProvider);
    //final show = ref.watch(itemListFilterProvider);
    final show = ref.watch(cityFilterStateForMap);

    late TextEditingController controller;

    return Scaffold(
      body: markersState.when(
          data: (markers) => markers.isEmpty
              ? const Center(
                  child: Text(
                    'no barbershop to display',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              : Stack(children: [
                  GoogleMap(
                    markers: markersContent,
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  infoWindow(),
                  //buildBottomPart(show, ref),
                  AutoComplete(optionsState, ref),

                ]
          ),
          error: (e, _) => Text("faszom"),
          loading: () => CircularProgressIndicator()
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding:EdgeInsets.fromLTRB(0, 0, 0, 50),
        onPressed: _animateToUser,
        label: Text('To the asdasdasdasdasda!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Padding AutoComplete(AsyncValue<List<String>> optionsState, WidgetRef ref) {
    return Padding(
                  padding: const EdgeInsets.fromLTRB(100, 30, 100, 0),
                  child: Autocomplete<String>(optionsBuilder:
                      (textEditingValue) async {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return optionsState.when(
                        data: (data) {
                          return data.where((String option) {
                            return option.contains(textEditingValue.text
                                .trim()); //TODO CASE INSENSITIVITY
                          });
                        },
                        error: (error, _) => const Iterable<String>.empty(),
                        loading: () => const Iterable<String>.empty());
                  }, optionsViewBuilder:
                      (context, Function(String) onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(4.0)),
                        ),
                        elevation: 4,
                        child: Container(
                          color: Colors.grey,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: options.length,
                            shrinkWrap: false,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);

                              return ListTile(
                                tileColor: Colors.transparent,
                                title: Text(option.toString()),
                                subtitle: Text("This is subtitle"),
                                onTap: () {
                                  onSelected(option.toString());
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }, fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    controller = controller;
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        hintText: "Search Something",
                        prefixIcon: Icon(Icons.search),
                      ),
                    );
                  }, onSelected: (String selected) async {
                    //set zoom and location to that city
                    ref.read(cityListFilterProvider.notifier).state =
                        selected; //TODO SET VIA NOTIFIER
                    //todo itt már a pinek automatikusan updatelodnek, csak oda kell mozgatni a kamerát a VÁROSRA
                    Marker m =
                        ref.read(markerListContentProvider).elementAt(0);
                    _goToCity(
                        GeoPoint(m.position.latitude, m.position.longitude));
                  }),
                );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToCity(GeoPoint city) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition pointToGo = CameraPosition(
        bearing: 0,
        target: LatLng(city.latitude, city.longitude),
        tilt: 10,
        zoom: 12.5);
    controller.animateCamera(CameraUpdate.newCameraPosition(pointToGo));
  }

  Future<void> _animateToUser() async {
    var pos = await location.getLocation();
    print(pos.toString());
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(pos.latitude!, pos.longitude!))
    ));
  }

  Widget buildBottomPart(String state,WidgetRef ref) {
    //if(state == ItemListFilter.all){
      return Positioned(
          top:0,
          child: Container(
            height: 40,
            width: 300,
            color: Colors.yellow,
            child: TextButton(
              child: Text(state.toString()),
              //icon: Icon(Icons.cancel),
              onPressed:(){ ref.read(cityFilterStateForMap.notifier).state="";},
            ),
          )
      );
    //}
    //return SizedBox();
  }

}
