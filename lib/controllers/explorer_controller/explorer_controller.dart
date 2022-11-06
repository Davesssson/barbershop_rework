import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/controllers/pagination/pagination_state.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';

import '../../models/barber/barber_model.dart';
import '../../repositories/barber_repository.dart';

class BarberPaginationNotifier extends StateNotifier<PaginationState<Barber>> {
  final Reader read;
  BarberPaginationNotifier( this.read) : super(const PaginationState.loading()){
    fetchFirstBatchMine();
  }

  //final Future<List<Barbershop>> Function(Barbershop? item) fetchNextItems;
  final int itemsPerBatch =3;
  final List<Barber> items = [];
  Timer _timer = Timer(const Duration(milliseconds: 0), () {});
  bool noMoreItems = false;

  void init() {
    if (items.isEmpty) {
      fetchFirstBatch();
    }
  }

  Future<void> fetchFirstBatchMine() async {
    try {
      state = const PaginationState.loading();
      final List<Barber> result = (await read(barberRepositoryProvider).retrieveBarbersForPagination()).cast<Barber>();
      updateData(result);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }
  Future<void> fetchNextBatchMine() async {
    if (_timer.isActive && items.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});
    print("new data is fetched");
    if (noMoreItems) {
      return;
    }

    if (state == PaginationState<Barber>.onGoingLoading(items)) {
      log("Rejected");
      return;
    }

    log("Fetching next batch of items");

    state = PaginationState.onGoingLoading(items);

    try {
      print("helo");
      //await Future.delayed(const Duration(seconds: 1));
      //final List<Barbershop> result = (await read(barbershopRepositoryProvider).retrieveMoreBarbershops(items.last)).cast<List<Barbershop>>() ;
      final List<Barber>  result = await read(barberRepositoryProvider).retrieveMoreBarbersForPagination(items.last);
      print(result.length.toString());
      updateData(result);
    } catch (e, stk) {
      log("Error fetching next page", error: e, stackTrace: stk);
      state = PaginationState.onGoingError(items, e, stk);
    }
  }



  Future<void> fetchFirstBatch() async {
    try {
      state = const PaginationState.loading();

      /* final List<Barbershop> result = items.isEmpty
          ? await fetchNextItems(null)
          : await fetchNextItems(items.last);
      updateData(result);*/
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  void updateData(List<Barber> result) {
    noMoreItems = result.length < itemsPerBatch;
    print("update data");

    if (result.isEmpty) {
      print("state data valtozott");
      state = PaginationState.data(items);
    } else {
      print("state data hozzaadott");
      state = PaginationState.data(items..addAll(result));
    }
  }



  Future<void> fetchNextBatch() async {
    if (_timer.isActive && items.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});
    print("new data is fetched");
    if (noMoreItems) {
      return;
    }

    if (state == PaginationState<Barber>.onGoingLoading(items)) {
      log("Rejected");
      return;
    }

    log("Fetching next batch of items");

    state = PaginationState.onGoingLoading(items);

    try {
      //await Future.delayed(const Duration(seconds: 1));
      //final result = await fetchNextItems(items.last);
      //log(result.length.toString());
      //updateData(result);
    } catch (e, stk) {
      log("Error fetching next page", error: e, stackTrace: stk);
      state = PaginationState.onGoingError(items, e, stk);
    }
  }
}
