import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:riverpod/riverpod.dart';

import '../../models/availability/availability_model.dart';
import '../../repositories/barber_repository.dart';

class AvailabilityListStateController extends StateNotifier<AsyncValue<List<Availability>>>{
  final Reader _read;
  AvailabilityListStateController(this._read):super(AsyncValue.loading()){
    retrieveAvailabilityTimeSlots();
  }

  Future<void> retrieveAvailabilityTimeSlots({bool isRefreshing = false})async{
    if(isRefreshing) state = AsyncValue.loading();
    try{
      final items = await _read(barberRepositoryProvider).retrieveAvailability('barberId');
      if(mounted){
        state = AsyncValue.data(items);
        print("AvailabilityListController state = " + state.toString());
      }
    }on CustomException catch(e){
      state = AsyncValue.error(e);
    }
  }


}