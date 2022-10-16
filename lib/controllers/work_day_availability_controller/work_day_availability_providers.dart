
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/work_day_availability/work_day_availability_model.dart';

final WorkDayAvailabilityFilterProvider = StateProvider<DateTime>((_) => DateTime.now());

final WorkDayAvailabilityListContentProvider = Provider.family<WorkDayAvailability,String>((ref,id){
  final filterDate = ref.watch(WorkDayAvailabilityFilterProvider);
  final workdaysAvailable = ref.watch(WorkDayAvailabilityListStateProvider(id));
  return workdaysAvailable.maybeWhen(
    data:(days){
      print("beleptem ebbe az agba");
      print(days.where((day) => day.id.toString()==filterDate.toString().split(" ")[0]).first);
      return days.where((day) => day.id.toString()==filterDate.toString().split(" ")[0]).first;
      } ,
    orElse: (){
      print("beleptem a masik agba");
      return WorkDayAvailability();
    }
  );
});

final WorkDayAvailabilityListStateProvider = StateNotifierProvider.family<WorkDayAvailabilityListStateController, AsyncValue<List<WorkDayAvailability>>,String?>((ref,id) {
  return WorkDayAvailabilityListStateController(ref.read,id);
});