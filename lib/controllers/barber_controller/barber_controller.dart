import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../models/barber/barber_model.dart';
import '../../models/booking/booking_model.dart';
import '../../repositories/barber_repository.dart';
import '../../repositories/custom_exception.dart';
import 'dart:developer' as developer;

class BarberListStateController extends StateNotifier<AsyncValue<List<Barber>>>{
  final Reader _read;
  BarberListStateController(this._read):super(AsyncValue.loading()){
    developer.log("[barber_controller.dart][BarberListStateController][BarberListStateController] - BarberListStateController constructed.");
    retrieveBarbers();
  }

  BarberListStateController.forShop( this._read):super(AsyncValue.loading()){
    developer.log("[barber_controller.dart][BarberListStateController][BarberListStateController] - BarberListStateForShopController constructed.");
    //retrieveBarbersFromShop2("asd");
    retrieveBarbersFromShopOnlyForAdmin();
  }

  Future<void> retrieveBarbers({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
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
        //state = AsyncValue.data( List.from(items as List<Barber>));
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveSingleBarber] - retrieveSingleBarber Exception.");
      state = AsyncValue.error(e);
    }
  }
  Future<void> retrieveBarbersFromShopOnlyForAdmin( {bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final items = await _read(barberRepositoryProvider).retrieveBarbersFromShop2('7HTJ8DF8hFwUnrL566Wc');
      if (mounted) {
        state = AsyncValue.data(items);
        MyLogger.singleton.logger().i("BarberListStateController = " + state.toString());
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
        MyLogger.singleton.logger().i("BarberListStateController = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][retrieveBarbersFromShop2] - retrieveBarbersFromShop Exception.");
      state = AsyncValue.error(e);
    }
  }
  Future<void> updateBarber({required Barber updatedBarber}) async {
    try {
      developer.log("[barber_controller.dart][BarberListStateController][updateBarber] - updateBarber ");
      await _read(barberRepositoryProvider)
          .updateBarber(barber: updatedBarber);
      state.whenData((barbers) {
        state = AsyncValue.data([
          for (final barber in barbers)
            if (barber.id == updatedBarber.id) updatedBarber else barber
        ]);
        MyLogger.singleton.logger().i("BarberListStateController = " + state.toString());
      });
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][updateBarber] - updateBarber exception");
    }
  }

  Future<void> addBarber({
    required String name,
    required String description,
    required String shopId
  }) async {
    try {
      developer.log("[barber_controller.dart][BarberListStateController][addBarber] - addBarber");
      final newBarber = Barber(name: name, description: description, barbershop_id: shopId );
      final createdBarberId = await _read(barberRepositoryProvider).createBarber(
        //userId: _userId!,
        newBarber: newBarber,
      );
      state.whenData((items) =>
      state = AsyncValue.data(items..add(newBarber.copyWith(id: createdBarberId))));
      MyLogger.singleton.logger().i("BarberListStateController = " + state.toString());
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][updateBarber] - addBarber exception");
      //_read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> addBooking({
    required String dateId,
    required String uId,
    required String barberId,
    required int start,
    required int end
  }) async {
    try {
      developer.log("[barber_controller.dart][BarberListStateController][addBooking] - addBooking");
       await _read(barberRepositoryProvider).addBooking(
        dateId: dateId,
        barberId: barberId,
        uId:uId,
        start: start
      );
       //TODO
    } on CustomException catch (e) {
      developer.log("[barber_controller.dart][BarberListStateController][updateBarber] - addBooking exception");
    }
  }

}