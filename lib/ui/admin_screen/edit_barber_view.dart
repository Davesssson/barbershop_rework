import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_providers.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../controllers/timeslot/timeslot_providers.dart';
import '../../models/availability/availability_model.dart';
import '../../models/barber/barber_model.dart';
//https://stackoverflow.com/questions/68369473/how-to-split-two-times-using-frequency-in-dart

class editView extends HookConsumerWidget {
  final Barber? barberUnderEdit;
  editView({Key? key, this.barberUnderEdit}) : super(key: key);
  final List<Appointment> changedElements = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textNameController = useTextEditingController(text: barberUnderEdit?.name ?? 'Default Name');
    final textDescriptionController = useTextEditingController(
        text: barberUnderEdit?.description ?? 'Default Description');
    final availbilityState = ref.watch(AvailabilityListStateProvider);
    final availabilityContent = ref.watch(AvailabilityListContentProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          color: Colors.grey,
          child: Column(
            children: [
              Text("Name"),
              TextFormField(
                controller: textNameController,
              ),
              Text("Description"),
              TextFormField(
                controller: textDescriptionController,
                maxLines: 3,
              ),
              TextButton(
                  onPressed: () {
                    // más providernél nem fog updatelődni amig ujra le nem kérik
                    barberUnderEdit != null
                        ? {
                            print("nem vagyok nulla, tudok updatelődni"),
                            ref
                                .read(barberListForShopStateProvider.notifier)
                                .updateBarber(
                                    updatedBarber: barberUnderEdit!.copyWith(
                                        name: textNameController.text.trim(),
                                        description: textDescriptionController
                                            .text
                                            .trim()))
                          }
                        : {
                            print("nulla vagyok, nem tudok updatelődni"),
                            ref
                                .read(barberListForShopStateProvider.notifier)
                                .addBarber(
                                    name: textNameController.text.trim(),
                                    description:
                                        textDescriptionController.text.trim(),
                                    shopId: '7HTJ8DF8hFwUnrL566Wc')
                          };
                  },
                  child: barberUnderEdit == null
                      ? Text("hozz Létre és adj hozzá egy fodrászt")
                      : Text("mentsd el a fodrász változtatásait")),
              TextButton(
                child: Text("updateld a calendart!"),
                onPressed: (){

                },
              ),
              Expanded(
                child: SfCalendar(
                  view: CalendarView.week,
                  allowDragAndDrop: true,
                  allowAppointmentResize: true,
                  onAppointmentResizeEnd: (AppointmentResizeEndDetails details){
                    changedElements.add(details.appointment);
                    print(details.startTime.toString());
                    print(details.endTime.toString());
                    print(details.resource.toString());
                    print(details.appointment.toString());
                  },
                  onTap: (CalendarTapDetails details){
                    print(details.resource.toString());
                    print(details.appointments.toString());
                    print(details.targetElement.toString());
                    print(details.date.toString());
                  },
                  dataSource: _getCalendarDataSource(availbilityState,availabilityContent),
                ),
              )
            ],
          ),
        )
    );
  }
  _AppointmentDataSource _getCalendarDataSource(AsyncValue<List<Availability>> state, Availability content) {
    List<Appointment> appointments = <Appointment>[];
    var uuid = Uuid();
    state.when(
        data: (data){
           data.forEach((availabilityDate) {
             availabilityDate.slots!.forEach((availabilityTimeSlot) {
               final List<String> date_split = availabilityDate.id!.split("-");
               final int start_hour = int.parse(availabilityTimeSlot.start.toString().substring(0,2));
               final int start_min = int.parse(availabilityTimeSlot.start.toString().substring(2));
               final int end_hour = int.parse(availabilityTimeSlot.end.toString().substring(0,2));
               final int end_min = int.parse(availabilityTimeSlot.end.toString().substring(2));
               final asd =  Appointment(
                 id: availabilityTimeSlot.id,
                 startTime: DateTime(
                  int.parse(date_split[0]),
                  int.parse(date_split[1]),
                  int.parse(date_split[2]),
                  start_hour,
                  start_min,
                ),
                 endTime: DateTime(
                   int.parse(date_split[0]),
                   int.parse(date_split[1]),
                   int.parse(date_split[2]),
                   end_hour,
                   end_min,
                 ),
              );
               appointments.add(asd);
            });
          });
        },
        error: (e,_){print("fos");},
        loading: (){}
    );
/*    appointments.add(
        Appointment(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(minutes: 30)),
          subject: 'Meeting',
          color: Colors.blue,
        )
    );*/

    return _AppointmentDataSource(appointments);
  }
}



class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
