import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import '../../models/city/city_model.dart';
import 'city_controller.dart';

final cityListFilterProvider = StateProvider<String>((_) => "");

final cityListStateProvider2 = StateNotifierProvider<CityListStateController, AsyncValue<List<City>>>((ref) {
  developer.log("[city_providers.dart][-][cityListStateProvider] - cityListStateProvider");
  return CityListStateController.forModel(ref.read);
},
);