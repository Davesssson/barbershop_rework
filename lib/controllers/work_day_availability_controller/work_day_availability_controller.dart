import 'package:flutter_shopping_list/models/work_day_availability/work_day_availability_model.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:riverpod/riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../repositories/barber_repository.dart';
import 'dart:developer' as developer;
class WorkDayAvailabilityListStateController extends StateNotifier<AsyncValue<List<WorkDayAvailability>>>{
  final Reader _read;
  WorkDayAvailabilityListStateController(this._read):super(AsyncValue.loading()){
    retrieveWorkDayAvailability();
  }

  Future<void> retrieveWorkDayAvailability({bool isRefreshing = false})async{
    if(isRefreshing) state = AsyncValue.loading();
    try{
      final items = await _read(barberRepositoryProvider).retrieveWorkDayAvailability('barberId');
      if(mounted){
        state = AsyncValue.data(items);
        print("WorkDayAvailabilityListController state = " + state.toString());
      }
    }on CustomException catch(e){
      state = AsyncValue.error(e);
    }
  }

  Future<void> updateBarberWorkDayAvailability({required List<Appointment>? changes, required String barberId }) async {
    try {
      developer.log("[barber_controller.dart][BarberListStateController][updateBarberWorkDayAvailability] - updateBarberWorkDayAvailability ");
      print("changes"+changes.toString());
      if(changes!.isEmpty) return
        print("itt mar nem fut le");
      changes.forEach((appointment) async {
        final startsplit = appointment.startTime.toString().split(" ");
        final startsplit2 = startsplit[1].split(":");
        String startHour = startsplit2[0];
        String startMinute = startsplit2[1];
        int start = int.parse(startHour+startMinute);

        final endsplit = appointment.endTime.toString().split(" ");
        final endsplit2 = endsplit[1].split(":");
        String endHour = endsplit2[0];
        String endMinute = endsplit2[1];
        int end=int.parse(endHour+endMinute);
        await _read(barberRepositoryProvider)
            .updateWorkDayAvailability(barberId: barberId,appointment: appointment);

        WorkDayAvailability neww = WorkDayAvailability(id: appointment.id.toString(),start: start,end:end);

        state.whenData((days) {
          state = AsyncValue.data([
            for (final day in days)
              if (day.id == appointment.id) neww else day
          ]);
        });

      });


    } on CustomException catch (e) {
      developer.log("[item_list_controller.dart][ItemListController][updateItem] - updateItem Exception ");

      // _read(itemListExceptionProvider).state = e;
    }
  }




}