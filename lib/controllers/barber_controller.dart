import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/barber/barber_model.dart';
import '../repositories/barber_repository.dart';
import '../repositories/custom_exception.dart';
import 'dart:developer' as developer;


final barberListContentProvider = Provider<List<Barber>>((ref) {
  developer.log("[barber_controller.dart][-][barberListContentProvider] - barberListContentProvider.");
  final barbersListState = ref.watch(barberListStateProvider);
  return barbersListState.maybeWhen(
    data: (barbers) {
      switch ("asd") {
        default:
          return barbers;
      }
    },
    orElse: () => [],
  );
});

final barberListStateProvider = StateNotifierProvider<BarberListStateController, AsyncValue<List<Barber>>>((ref) {
  developer.log("[barber_controller.dart][-][barberListStateProvider] - barberListStateProvider.");
  return BarberListStateController(ref.read);
},);

class BarberListStateController extends StateNotifier<AsyncValue<List<Barber>>>{
  final Reader _read;
  BarberListStateController(this._read):super(AsyncValue.loading()){
    developer.log("[barber_controller.dart][BarberListStateController][BarberListStateController] - BarberListStateController constructed.");
    retrieveBarbers();
  }

  Future<void> retrieveBarbers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbers] - retrieveBarbers.");
      final items = await _read(barberRepositoryProvider).retrieveBarbers();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbers] - retrieveBarbers Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveSingleBarber(String id, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveSingleBarber] - retrieveSingleBarber.");
      final items = await _read(barberRepositoryProvider).retrieveSingleBarbersFromShop(id);
      if (mounted) {
        List<Barber> asd=[]; asd.add(items);
        state = AsyncValue.data(asd);
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveSingleBarber] - retrieveSingleBarber Exception.");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveBarbersFromShop(List<String> ids, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbersFromShop] - retrieveBarbersFromShop.");
      final items = await _read(barberRepositoryProvider).retrieveBarbersFromShop(ids);
      if (mounted) {
        state = AsyncValue.data(items);
        developer.log("state = " + items.toString());

      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbersFromShop] - retrieveBarbersFromShop Exception.");
      state = AsyncValue.error(e);
    }
  }
  Future<void> retrieveBarbersFromShop2(String shopId, {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbersFromShop2] - retrieveBarbersFromShop2.");
      final items = await _read(barberRepositoryProvider).retrieveBarbersFromShop2(shopId);
      if (mounted) {
        state = AsyncValue.data(items);
        developer.log("itt vagyok state = " + items.toString());
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbersFromShop2] - retrieveBarbersFromShop Exception.");
      state = AsyncValue.error(e);
    }
  }


}