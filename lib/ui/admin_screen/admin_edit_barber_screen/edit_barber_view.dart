import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_providers.dart';
import 'package:flutter_shopping_list/models/work_day_availability/work_day_availability_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_providers.dart';
import 'package:flutter_shopping_list/repositories/barber_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:image_picker_web/image_picker_web.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../general_providers.dart';
import '../../../models/barber/barber_model.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_edit_barber_screen/widgets/editWorkdayDialog.dart';

import 'widgets/barberWorksGridView.dart';
import 'widgets/editNameAndDescription.dart';
import 'widgets/updateCalendarButton.dart';
//https://stackoverflow.com/questions/68369473/how-to-split-two-times-using-frequency-in-dart

class editView extends HookConsumerWidget {
  final Barber? barberUnderEdit;
  editView({Key? key, this.barberUnderEdit}) : super(key: key);


  List<Appointment> appointments = <Appointment>[];
  final List<Appointment> changedElements = [];
  final List<Appointment> addedElements = [];
  //final picker = ImagePicker();


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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(barberUnderEdit!=null? barberUnderEdit!.name! +"módosítása" : "Új barber létrehozása"),
          actions: [
            barberUnderEdit!=null? Row(
              children: [
                Text("Barber törlése"),
                IconButton(
                    onPressed: (){
                      ref.read(barberListForShopStateProvider(barberUnderEdit!.barbershop_id!).notifier) // TODO KICSERÉLNI SIMA ASYNC-ra
                          .deleteBarber(barberId: barberUnderEdit!.id!);
                    },
                    icon: Icon(Icons.delete_forever)
                ),
              ],
            ): SizedBox()
          ],

        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          color: Colors.grey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                editNameAndDescription(textNameController: textNameController, textDescriptionController: textDescriptionController, barberUnderEdit: barberUnderEdit),
                SingleChildScrollView(
                  child: Container(
                    height: 700,
                    child: SfCalendar(
                      showNavigationArrow: true,
                      todayHighlightColor: Theme.of(context).primaryColor,
                      dataSource: _events,
                      view: CalendarView.week,
                      allowDragAndDrop: false,
                      allowAppointmentResize: true,
                      onAppointmentResizeEnd: (AppointmentResizeEndDetails details){
                        changedElements.add(details.appointment); //TODO Mi van akkor, hogyha többször resizeolja és hozzáadódiK????
                      },

                      onTap: (CalendarTapDetails details){
                        String dateId = getDateId(details);
                        if(!hasAppointmentWithId(dateId)) {
                          DateTime start = getStartTime(details);
                          DateTime end = getEndTime(details, 8);
                          final Appointment newAppointment = Appointment(
                              id: dateId,
                              startTime: start,
                              endTime: end
                          );
                          appointments.add(newAppointment);
                          addedElements.add(newAppointment);
                          _events.notifyListeners(
                              CalendarDataSourceAction.add,
                              <Appointment>[newAppointment]);
                        }
                        else{
                          if(details.date!.isAfter(DateTime.now()..add(Duration(days: 1)))) { //holnaptól számítva
                            print("helokaasd");
                            editWorkDayDialog.show(context, details, barberUnderEdit!.id!);
                          }
                        }
                      },
                    ),
                  ),
                ),
                updateCalendarButton(
                    barberUnderEdit: barberUnderEdit,
                    changedElements: changedElements,
                    addedElements: addedElements
                ),
                barberWorksGridView(barberUnderEdit: barberUnderEdit,),
/*                TextButton( // TODO EZ MOBILON ELTÖRI A DOLGOKAT
                    onPressed: ()async {
                      Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                      final url = bytesFromPicker.hashCode;
                      //await ref.read(barberListStateProvider.notifier).addWorkToBarber(barberId: barberUnderEdit!.id!, image: bytesFromPicker!);

                      final asdfg = await ref.read(firebaseStorageProvider).ref().child("/${url}/").putData(bytesFromPicker!,SettableMetadata(contentType: "image"));
                      final asdfg_download_link = await ref.read(firebaseStorageProvider).ref().child("/${url}/").getDownloadURL();
                      await ref.read(firebaseFirestoreProvider).collection('barbers').doc(barberUnderEdit!.id).update({'works':FieldValue.arrayUnion([asdfg_download_link])});

                      },
                    child: Text("Tölts fel képet",style: TextStyle(color: Colors.red),)
                ),*/

              ],
            ),
          ),
        )
    );
  }

  void _calendarOnTapCallback(CalendarTapDetails details){

  }

  _AppointmentDataSource _getCalendarDataSource2(AsyncValue<List<WorkDayAvailability>> state/*, WorkDayAvailability content*/) {
    state.when(
        data: (data){
          data.isEmpty
          ?{print("ures vagyok")}
          :data.forEach((workDayAvailability) {
            final List<String> date_split = workDayAvailability.id!.split("-");
            final int start_hour;
            final int start_min;
            if(workDayAvailability.start.toString().length==3){
              start_hour = int.parse(workDayAvailability.start.toString()[0]);
              start_min = int.parse(workDayAvailability.start.toString().substring(1));
            }else{
              start_hour = int.parse(workDayAvailability.start.toString().substring(0,2));
              start_min = int.parse(workDayAvailability.start.toString().substring(2));
            }


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

  String getDateId(CalendarTapDetails details) {
    String year = details.date!.year.toString();
    String month = details.date!.month.toString();
    String day = details.date!.day.toString();
    if(day.length<2){
      day="0"+day;
    }
    String id = year + "-" + month + "-" + day;
    return id;
  }

  DateTime getStartTime(CalendarTapDetails details) {
    int year = details.date!.year;
    int month = details.date!.month;
    int day = details.date!.day;
    int startHour = details.date!.hour;
    int startMin = details.date!.minute;
    DateTime start = DateTime(
        year, month, day,
        startHour, startMin);
    return start;
  }

  DateTime getEndTime(CalendarTapDetails details, int workDayLengthInHour) {
    int year = details.date!.year;
    int month = details.date!.month;
    int day = details.date!.day;
    int endHour = details.date!.hour;
    int endMin = details.date!.minute;
    DateTime end = DateTime(
        year, month, day,
        endHour+workDayLengthInHour, endMin);
    return end;
  }

}



class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

