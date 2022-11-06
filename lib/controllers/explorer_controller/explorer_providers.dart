

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/barber/barber_model.dart';
import '../pagination/pagination_state.dart';
import 'explorer_controller.dart';

final BarberPaginationNotifierProvider = StateNotifierProvider<BarberPaginationNotifier, PaginationState<Barber>>((ref) {
  return BarberPaginationNotifier(ref.read);
});