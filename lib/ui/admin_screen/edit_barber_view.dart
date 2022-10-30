import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../general_providers.dart';
import '../../models/barber/barber_model.dart';
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
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          color: Colors.grey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                editNameAndDescription(textNameController: textNameController, textDescriptionController: textDescriptionController, barberUnderEdit: barberUnderEdit),
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
                        ? Text("hozz Létre és adj hozzá egy fodrászt",style: TextStyle(color:Colors.black))
                        : Text("mentsd el a fodrász változtatásait",style: TextStyle(color:Colors.black))),
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

                IconButton(
                    onPressed: (){
                      ref.read(barberListForShopStateProvider.notifier) // TODO KICSERÉLNI SIMA ASYNC-ra
                          .deleteBarber(barberId: barberUnderEdit!.id!);
                    },
                    icon: Icon(Icons.delete_forever)
                ),

                SingleChildScrollView(
                  child: Container(
                    child: SfCalendar(
                      dataSource: _events,
                      view: CalendarView.week,
                      allowDragAndDrop: true,
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
                GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: (MediaQuery.of(context).size.width / 350).toInt(),
                  children: [
                    ...barberUnderEdit!.works!.map((picture) {
                      return InkWell(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => showConfirmationDialog(context, ref, picture),
                        ),
                        child: Image.network(picture),
                      );
                    }).toList(),
                    Container(color:Colors.blue,child:Icon(Icons.add))
                  ],
                ),
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

  AlertDialog showConfirmationDialog(BuildContext context, WidgetRef ref, String picture) {
    return AlertDialog(
      title: const Text('Biztosan meg szeretnéd változtatni a barber profil képét?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ref.read(barberListForShopStateProvider.notifier) // TODO KICSERÉLNI SIMA ASYNC-ra
                .updateBarberProfPic(barberId: barberUnderEdit!.id!, profPictureLink: picture);
            Navigator.pop(context, 'Yes');
          },
          child: const Text('OK'),
        ),
      ],
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

class editNameAndDescription extends StatelessWidget {
  const editNameAndDescription({
    Key? key,
    required this.textNameController,
    required this.textDescriptionController,
    required this.barberUnderEdit,
  }) : super(key: key);

  final TextEditingController textNameController;
  final TextEditingController textDescriptionController;
  final Barber? barberUnderEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text("Name"),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/3,
                child: TextFormField(controller: textNameController),
              ),
            ),
            Text("Description"),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/3,
                child: TextFormField(controller: textDescriptionController),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black
                )
              ),
              child: InkWell(
                  onHover: (onHover){
                     onHover?Container(color: Colors.red):Container(color:Colors.blue);
                  },
                  child: Image.network(barberUnderEdit!.prof_pic!)
              )
            )
          ],
        )
      ],
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}


class editWorkDayDialog extends HookConsumerWidget {
  static void show(BuildContext context, CalendarTapDetails details, String barberId) {
    showDialog(
      context: context,
      builder: (context) => editWorkDayDialog(details: details,barberUnderEdit: barberId,),
    );
  }
  final String barberUnderEdit;
  final CalendarTapDetails details;

  const editWorkDayDialog({Key? key, required this.details, required this.barberUnderEdit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startController = useTextEditingController(text:details.date!.hour.toString());
    final endController = useTextEditingController(text:(details.date!..add(Duration(hours: 8))).hour.toString());
    return Dialog(
      child: Container(
        width:MediaQuery.of(context).size.width*3/4,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("start"),
            TextField(
              controller: startController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            Text("end"),
            TextField(
              controller: endController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*3/4,
              child: ElevatedButton(
                onPressed: () {
                  print(barberUnderEdit);
                  print(details.date.toString().split(" ")[0]);
                  print(startController.text.trim());
                  print(endController.text.trim());
                  ref.read(WorkDayAvailabilityListStateProvider(barberUnderEdit).notifier)
                      .modifyWorkDayAvailability(
                      barberUnderEdit,
                      details.date.toString().split(" ")[0],
                      int.parse(startController.text.trim()),
                      int.parse(endController.text.trim())
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
