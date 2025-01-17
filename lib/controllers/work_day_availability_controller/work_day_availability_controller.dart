import 'package:flutter_shopping_list/models/work_day_availability/work_day_availability_model.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:riverpod/riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../repositories/barber_repository.dart';
import 'dart:developer' as developer;

import '../../utils/logger.dart';
class WorkDayAvailabilityListStateController extends StateNotifier<AsyncValue<List<WorkDayAvailability>>>{
  final Reader _read;

  WorkDayAvailabilityListStateController(this._read, String? barberId):super(AsyncValue.loading()){
    developer.log("WorkDayAvailabilityListStateController constructed for ${barberId}");
    retrieveWorkDayAvailability(barberId);
  }

  Future<void> retrieveWorkDayAvailability(String? barberId,{ bool isRefreshing = false})async{
    if(isRefreshing) state = AsyncValue.loading();
    if(barberId ==null) return ;
    try{
      final items = await _read(barberRepositoryProvider).retrieveWorkDayAvailability(barberId);
      if(mounted){
        state = AsyncValue.data(items);
        print("WorkDayAvailabilityListController state = " + state.toString());
      }
    }on CustomException catch(e){
      state = AsyncValue.error(e);
    }
  }

  Future<void> modifyWorkDayAvailability(String? barberId,String? workdayId, int newStart, int newEnd, { bool isRefreshing = false})async{
    if(isRefreshing) state = AsyncValue.loading();
    if(barberId ==null) return ;
    try{
       await _read(barberRepositoryProvider).modifyWorkdayAvailability(barberId: barberId, workdayId: workdayId!, newStart: newStart, newEnd: newEnd);
/*      if(mounted){
        state = AsyncValue.data(items);
        print("WorkDayAvailabilityListController state = " + state.toString());
      }*/
    }on CustomException catch(e){
      state = AsyncValue.error(e);
    }
  }

  Future<bool> updateBarberWorkDayAvailability({required List<Appointment>? changes, required String barberId }) async {
    try {
      developer.log("[work_day_controller.dart][WorkDayAvailabilityListStateController][updateBarberWorkDayAvailability] - updateBarberWorkDayAvailability ");
      print("changes"+changes.toString());
      if(changes!.isEmpty) {
        developer.log("There has been no modification to the working hours");
        return false;
      }
      changes.forEach((appointment) async {
        int newStart = calculateNewTime(appointment.startTime);
        int newEnd = calculateNewTime(appointment.endTime);

        await _read(barberRepositoryProvider)
            .updateWorkDayAvailability(barberId: barberId,appointmentId: appointment.id.toString(), newStart: newStart, newEnd: newEnd);
        WorkDayAvailability neww = WorkDayAvailability(id: appointment.id.toString(),start: newStart,end:newEnd);

        state.whenData((days) {
          state = AsyncValue.data([
            for (final day in days)
              if (day.id == appointment.id) neww else day
          ]);
          MyLogger.singleton.logger().i("WorkDayAvailability state = "+state.toString());
        });
      });
      return true;  //TODO check return value
    } on CustomException catch (e) {
      return false;
      // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<bool> addBarberWorkDayAvailability({required List<Appointment>? addedAppointments, required String barberId }) async {
    try {
      developer.log("[work_day_controller.dart][WorkDayAvailabilityListStateController][updateBarberWorkDayAvailability] - updateBarberWorkDayAvailability ");
      print("added changes"+addedAppointments.toString());
      if(addedAppointments!.isEmpty) {
        developer.log("There has been no new added appointments");
        return false;
      }
      addedAppointments.forEach((appointment) async {
        int start = calculateNewTime(appointment.startTime);
        int end = calculateNewTime(appointment.endTime);

        await _read(barberRepositoryProvider)
            .addWorkDayAvailability(barberId: barberId, appointmentId: appointment.id.toString(), start: start, end: end);
        WorkDayAvailability neww = WorkDayAvailability(id: appointment.id.toString(), start: start,end:end);

        state.whenData((items) =>
        state = AsyncValue.data(items..add(neww.copyWith(id: neww.id))));
        MyLogger.singleton.logger().i("WorkDayAvailability state = "+state.toString());
      });
      return true;
    } on CustomException catch (e) {
      return false;
      // _read(itemListExceptionProvider).state = e;
    }
  }

  int calculateNewTime(DateTime initialTime) {
    final startsplit = initialTime.toString().split(" ");
    final startsplit2 = startsplit[1].split(":");
    String startHour = startsplit2[0];
    String startMinute = startsplit2[1];
    return int.parse(startHour+startMinute);
  }




}