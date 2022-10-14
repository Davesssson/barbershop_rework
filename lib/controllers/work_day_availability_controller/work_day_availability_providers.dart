
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/work_day_availability/work_day_availability_model.dart';

final WorkDayAvailabilityFilterProvider = StateProvider<DateTime>((_) => DateTime.now());

final WorkDayAvailabilityListContentProvider = Provider<WorkDayAvailability>((ref){
  final filterDate = ref.watch(WorkDayAvailabilityFilterProvider);
  final workdaysAvailable = ref.watch(WorkDayAvailabilityListStateProvider);
  return workdaysAvailable.maybeWhen(
    data:(days){
      print(days.where((day) => day.id.toString()==filterDate.toString().split(" ")[0]).first);
      return days.where((day) => day.id.toString()==filterDate.toString().split(" ")[0]).first;
      } ,
    orElse: ()=> WorkDayAvailability(),
  );
});

final WorkDayAvailabilityListStateProvider = StateNotifierProvider<WorkDayAvailabilityListStateController, AsyncValue<List<WorkDayAvailability>>>((ref) {
  return WorkDayAvailabilityListStateController(ref.read);
});