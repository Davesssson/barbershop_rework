import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../models/barbershop/barbershop_model.dart';
import 'barbershop_controller.dart';

final barbershopListFeaturedContentProvider = Provider<List<Barbershop>>((ref) {
  developer.log("[barbershop_providers.dart][-][barbershopListContentProvider] - barbershopListContentProvider.");
  final barbershopListFeaturedState = ref.watch(barbershopListFeaturedStateProvider);

  return barbershopListFeaturedState.maybeWhen(
    data: (shops) {
        return shops;

    },
    orElse: () => [],
  );
});

final barbershopListFeaturedStateProvider = StateNotifierProvider<BarbershopListStateController, AsyncValue<List<Barbershop>>>((ref) {
  developer.log("[barbershop_featured_providers.dart][-][barbershopListFeaturedStateProvider] - barbershopListFeaturedStateProvider.");
    return BarbershopListStateController.featured(ref.read);
  },
);