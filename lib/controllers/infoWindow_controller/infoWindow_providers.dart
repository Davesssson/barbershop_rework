import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;

import '../../ui/map_screen/map_screen.dart';
import 'infoWindow_controller.dart';

final barbershopForMapContentProvider = Provider<Barbershop?>((ref) {
  final filter = ref.watch(cityFilterStateForMap);
  final itemListState = ref.watch(barbershopForMapStateProvider(filter.split("(")[1].split(")")[0])); //tudom, hogy csúnya, de hidd el hogy ez kell
  return itemListState.maybeWhen(
    data: (items) {
      switch (filter) {
        default: if(filter!="")
          return items;
      }
    },
    orElse: () => null,
  );
});

final barbershopForMapStateProvider = StateNotifierProvider.family<infoWindowController, AsyncValue<Barbershop>,String>((ref,shopId) {
  developer.log("[infoWindow_providers.dart][-][barbershopForMapStateProvider] - barbershopForMapStateProvider");
  return infoWindowController(ref.read,shopId);
},
);