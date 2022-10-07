
import 'package:flutter_shopping_list/controllers/timeslot/timeslot_controller.dart';
import 'package:flutter_shopping_list/models/availability/availability_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final availabilityFilterProvider = StateProvider<DateTime>((_) => DateTime.now());

final AvailabilityListContentProvider = Provider<Availability>((ref){
  final filterDate = ref.watch(availabilityFilterProvider);
  final serviceTagsState = ref.watch(AvailabilityListStateProvider);
  return serviceTagsState.maybeWhen(
    data:(tags){
      print("content");
      print(tags.where((slot) => slot.id.toString() == filterDate.toString().split(" ")[0]).first);
      return tags.where((slot) => slot.id.toString() == filterDate.toString().split(" ")[0]).first;
    } ,
    orElse: ()=> Availability(slots: []),
  );
});

final AvailabilityListStateProvider = StateNotifierProvider<AvailabilityListStateController, AsyncValue<List<Availability>>>((ref) {
    return AvailabilityListStateController(ref.read);
});