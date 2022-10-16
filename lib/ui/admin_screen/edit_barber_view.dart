import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_providers.dart';
import 'package:flutter_shopping_list/models/work_day_availability/work_day_availability_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../models/barber/barber_model.dart';
//https://stackoverflow.com/questions/68369473/how-to-split-two-times-using-frequency-in-dart

class editView extends HookConsumerWidget {
  final Barber? barberUnderEdit;
  editView({Key? key, this.barberUnderEdit}) : super(key: key);


  List<Appointment> appointments = <Appointment>[];
  final List<Appointment> changedElements = [];
  final List<Appointment> addedElements = [];


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textNameController = useTextEditingController(text: barberUnderEdit?.name ?? 'Default Name');
    final textDescriptionController = useTextEditingController(
        text: barberUnderEdit?.description ?? 'Default Description');

    final List<WorkDayAvailability> emptyList = [];
    final workDayAvailabilityState;
    if(barberUnderEdit!=null) {
      workDayAvailabilityState = ref.watch(
          WorkDayAvailabilityListStateProvider(barberUnderEdit!.id!));
    }else{
      workDayAvailabilityState =  AsyncValue.data(emptyList);
    }
    //final workDayAvailabilityContent = ref.watch(WorkDayAvailabilityListContentProvider(barberUnderEdit!.id!));

    //ez itt kurvára nincsen jó helyen, mert minden egyes resizenál elemehet addol a listába. :cc
    late CalendarDataSource _events = _getCalendarDataSource2(workDayAvailabilityState/*, workDayAvailabilityContent*/);

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
              TextFormField(controller: textNameController),
              Text("Description"),
              TextFormField(
                controller: textDescriptionController,
                maxLines: 3,
              ),
              TextButton(
                  onPressed: () {
                    barberUnderEdit != null
                        ? {
                            print("nem vagyok nulla, tudok updatelődni"),
                            ref.read(barberListForShopStateProvider.notifier)
                               .updateBarber(
                                    updatedBarber: barberUnderEdit!.copyWith(
                                        name: textNameController.text.trim(),
                                        description: textDescriptionController
                                            .text
                                            .trim()
                                    )
                                  )
                          }
                        : {
                            print("nulla vagyok, nem tudok updatelődni"),
                            ref.read(barberListForShopStateProvider.notifier)
                               .addBarber(
                                    name: textNameController.text.trim(),
                                    description:textDescriptionController.text.trim(),
                                    shopId: '7HTJ8DF8hFwUnrL566Wc'
                                )
                          };
                  },
                  child: barberUnderEdit == null
                      ? Text("hozz Létre és adj hozzá egy fodrászt")
                      : Text("mentsd el a fodrász változtatásait")),
              TextButton(
                child: Text("updateld a calendart!",style: TextStyle(color:Colors.black),),
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
              Expanded(
                child: SfCalendar(
                  view: CalendarView.week,
                  allowDragAndDrop: true,
                  allowAppointmentResize: true,
                  onAppointmentResizeEnd: (AppointmentResizeEndDetails details){
                    changedElements.add(details.appointment); //TODO Mi van akkor, hogyha többször resizeolja és hozzáadódiK????
                  },
                  onTap: (CalendarTapDetails details){
                    String year = details.date!.year.toString();
                    String month = details.date!.month.toString();
                    String day = details.date!.day.toString();
                    String id = year + "-" + month + "-" + day;
                    if(!hasAppointmentWithId(id)) {
                      int startHour = details.date!.hour;
                      int startMin = details.date!.minute;
                      DateTime start = DateTime(
                          int.parse(year), int.parse(month), int.parse(day),
                          startHour, startMin);
                      DateTime end = DateTime(
                          int.parse(year), int.parse(month), int.parse(day),
                          startHour + 8, startMin);
                      final Appointment newAppointment = Appointment(
                          id: id,
                          startTime: start,
                          endTime: end
                      );
                      appointments.add(newAppointment);
                      print("sajat" + newAppointment.toString());

                      _events.notifyListeners(
                          CalendarDataSourceAction.add,
                          <Appointment>[newAppointment]);
                      addedElements.add(newAppointment);
                    }else{
                      print("heloka");
                    }
                  },
                  //dataSource: _getCalendarDataSource2(workDayAvailabilityState,workDayAvailabilityContent),
                  dataSource: _events
                ),
              )
            ],
          ),
        )
    );
  }

  _AppointmentDataSource _getCalendarDataSource2(AsyncValue<List<WorkDayAvailability>> state/*, WorkDayAvailability content*/) {
    state.when(
        data: (data){
          data.isEmpty
          ?{print("ures vagyok")}
          :data.forEach((workDayAvailability) {
            final List<String> date_split = workDayAvailability.id!.split("-");
            final int start_hour = int.parse(workDayAvailability.start.toString().substring(0,2));
            final int start_min = int.parse(workDayAvailability.start.toString().substring(2));
            final int end_hour = int.parse(workDayAvailability.end.toString().substring(0,2));
            final int end_min = int.parse(workDayAvailability.end.toString().substring(2));
            final asd =  Appointment(
              id: workDayAvailability.id,
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
            print("eztfigyeld");
            print(asd);
            appointments.add(asd);
          });
        },
        error: (e,_){print("fos");},
        loading: (){}
    );
    return _AppointmentDataSource(appointments);
  }

  bool hasAppointmentWithId(String id) {
    bool listAlreadyHasAppointmentWithId = false;
    appointments.forEach((element) {
      if(element.id==id){
        listAlreadyHasAppointmentWithId = true;
      }
    });
    return listAlreadyHasAppointmentWithId;
  }
}
//region old implementation
/*  _AppointmentDataSource _getCalendarDataSource(AsyncValue<List<Availability>> state, Availability content) {
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
    return _AppointmentDataSource(appointments);
  }*/
//endregion old implementation





class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
