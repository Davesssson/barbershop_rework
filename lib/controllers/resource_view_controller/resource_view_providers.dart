import 'package:flutter_shopping_list/controllers/resource_view_controller/resource_view_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:developer' as developer;
import '../../models/resource_view_model/resource_view_model.dart';

/*final barbershopListContentProvider = Provider<List<Barbershop>>((ref) {
  developer.log("[barbershop_providers.dart][-][barbershopListContentProvider] - barbershopListContentProvider.");

});*/

final resourceViewListStateProvider = StateNotifierProvider.family<ResourceViewListStateController, AsyncValue<List<ResourceViewModel>>,String>((ref,shopId) {
  developer.log("[barbershop_providers.dart][-][barbershopListStateProvider] - barbershopListStateProvider.");
  return ResourceViewListStateController(ref.read,shopId);
},
);