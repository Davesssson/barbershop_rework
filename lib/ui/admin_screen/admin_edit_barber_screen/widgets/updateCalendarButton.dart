import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../controllers/work_day_availability_controller/work_day_availability_providers.dart';
import '../../../../models/barber/barber_model.dart';

class updateCalendarButton extends ConsumerWidget {
  const updateCalendarButton({
    Key? key,
    required this.barberUnderEdit,
    required this.changedElements,
    required this.addedElements,
  }) : super(key: key);

  final Barber? barberUnderEdit;
  final List<Appointment> changedElements;
  final List<Appointment> addedElements;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          ),
          child: Text("Updateld a calendart!",style: TextStyle(color:Colors.black),),
          onPressed: () async{
            SnackBar sb_updated ;
            SnackBar sb_added;
            bool didUpdate = await ref.read(WorkDayAvailabilityListStateProvider(barberUnderEdit!.id!).notifier).updateBarberWorkDayAvailability(changes: changedElements, barberId: barberUnderEdit!.id!);
            if(didUpdate){
              changedElements.clear();
              sb_updated = SnackBar(
                content: const Text("Working hours updated"),
              );
            } else {
              sb_updated = SnackBar(content: const Text("No modifications took place"));
            }
            ScaffoldMessenger.of(context).showSnackBar(sb_updated);
            print("vale of the change "+ didUpdate.toString());
            bool didAdd = await ref.read(WorkDayAvailabilityListStateProvider(barberUnderEdit!.id!).notifier).addBarberWorkDayAvailability(addedAppointments: addedElements, barberId: barberUnderEdit!.id!);
            if(didAdd){
              addedElements.clear();
              sb_added = SnackBar(
                content: const Text("New Working hour updated"),
              );
            }else {
              sb_added = SnackBar(content: const Text("No addition took place"));
            }
            ScaffoldMessenger.of(context).showSnackBar(sb_added);
          }
      ),
    );
  }
}