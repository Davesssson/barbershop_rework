
import 'package:flutter_shopping_list/controllers/serviceTags_controller/serviceTags_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
final ServiceTagsListStateControllerProvider = StateNotifierProvider<ServiceTagsListStateController, AsyncValue<List<String>>>((ref) {
  developer.log("[service_providers.dart][-][serviceListStateProvider] - serviceListStateProvider");
  return ServiceTagsListStateController(ref.read);
},
);