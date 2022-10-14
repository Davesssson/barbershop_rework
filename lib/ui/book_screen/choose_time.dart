
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_providers.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../controllers/timeslot/timeslot_controller.dart';
import '../../controllers/timeslot/timeslot_providers.dart';
import '../../models/availability/availability_model.dart';
import '../../models/work_day_availability/work_day_availability_model.dart';

class chooseTime extends ConsumerStatefulWidget{
  const chooseTime({Key? key}):super(key:key);

  @override
  ConsumerState<chooseTime> createState()=>_chooseTimeState();
}


class _chooseTimeState extends ConsumerState<chooseTime> {

  final  List<DateTime> list =[];
  final  List<Widget> chips =[];

  @override
  void initState() {
    // TODO: implement initState
    for(int i =0;i<30;i++){
      list.add(DateTime.now().add(Duration(days:i)));
    }
    super.initState();
  }

  void prepareBlackoutDates(List<WorkDayAvailability> data){
    data.forEach((day) {
      final List<String> workDayString = day.id!.split("-");
      final DateTime workDayDateTime = DateTime(int.parse(workDayString[0]),int.parse(workDayString[1]),int.parse(workDayString[2]));
      print(workDayDateTime);
      print(list);
      list.removeWhere((element) {
        final List<String> dateInTheListString = element.toString().split(" ");
        final List<String> asd22 = dateInTheListString[0].toString().split("-");
        final date2 = DateTime(int.parse(asd22[0]),int.parse(asd22[1]),int.parse(asd22[2]));
        return date2==workDayDateTime;
      });
      print(list);

    });
  }


    List<Widget> prepareChipChoices(WorkDayAvailability availability){
      List<Widget> temp= [];
      DateTime start = DateTime(2022,10,14,int.parse(availability.start.toString().substring(0,2)),int.parse(availability.start.toString().substring(2)));
      DateTime end = DateTime(2022,10,14,int.parse(availability.end.toString().substring(0,2)),int.parse(availability.end.toString().substring(2)));
      for(start;start.isBefore(end);){
        DateTime improved2 = start.add(Duration(minutes:30));
        start=improved2;
        temp.add(Chip(label: Text("${start.hour}:${start.minute}")));
      }

    print(start);
    print(end);
    return temp;
    }

  @override
  Widget build(BuildContext context) {

    final workDayAvailabilityListState = ref.watch(WorkDayAvailabilityListStateProvider);
    final workDayAvailabilityListContent = ref.watch(WorkDayAvailabilityListContentProvider);

    return Scaffold(
      body:workDayAvailabilityListState.when(
          data: (data){
            prepareBlackoutDates(data);
            return ListView(
                children:[
                  SfDateRangePicker(
                    maxDate: DateTime.now().add(Duration(days:30)),
                    enablePastDates: false,
                    allowViewNavigation: true,
                    enableMultiView: false,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      firstDayOfWeek: 7,
                      numberOfWeeksInView: 1,
                      blackoutDates:[
                        ...list,
                      ],
                    ),
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs arg){
                      final date = arg.value.toString().split(" ");
                      final dateComponents = date[0].split("-");
                      ref.read(WorkDayAvailabilityFilterProvider.notifier).state = DateTime(int.parse(dateComponents[0]),int.parse(dateComponents[1]),int.parse(dateComponents[2]));
                      chips.clear();
                      print("WorkDayAvailabilityFilterState = "+ref.read(WorkDayAvailabilityFilterProvider.notifier).state.toString());
                      print(arg.value.toString());
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/10,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...prepareChipChoices(workDayAvailabilityListContent)
                      ],
                    ),
                  ),
                ]
            );
          },
          error: (e,_){return Text("asdasdasd");},
          loading: (){return CircularProgressIndicator();}
      )

    );
  }


}

//region old implementation
/* body:details.when(
          data: (data) {
            print("eloszor");
            print(list.toString());
            data.forEach((element1) {
              final asd = element1.id!.split("-");
              final date = DateTime(int.parse(asd[0]),int.parse(asd[1]),int.parse(asd[2]));
              list.removeWhere((element) {
                List<String> asd2 = element.toString().split(" ");
                List<String> asd22 = asd2[0].toString().split("-");
                final date2 = DateTime(int.parse(asd22[0]),int.parse(asd22[1]),int.parse(asd22[2]));
                return date==date2;
              });
            });
            print("masodszor");
            print(list.toString());
            return ListView(
              children:[
                  SfDateRangePicker(
                    maxDate: DateTime.now().add(Duration(days:30)),
                    enablePastDates: false,
                    allowViewNavigation: true,
                    enableMultiView: false,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      firstDayOfWeek: 7,
                      numberOfWeeksInView: 1,
                      blackoutDates:[
                        ...list,
                        ...data.map((e) { // ide még kell egy csekk, hogy csak akkor legyen engedélyezett hogyha van szabad timeslot
                          final asd = e.id!.split("-");
                          print(asd);
                          return DateTime(int.parse(asd[0]),int.parse(asd[1]),int.parse(asd[2]));
                        }).toList()
                      ],
                    ),
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs arg){
                      final date = arg.value.toString().split(" ");
                      final dateComponents = date[0].split("-");
                      print("date");
                      print(date.toString());
                      print("dateComponents");
                      print(dateComponents.toString());
                      print("AvailabilityFilterProvider state = ");
                      print(ref.read(availabilityFilterProvider.notifier).state.toString());
                      print("most állítom át");
                      ref.read(availabilityFilterProvider.notifier).state = DateTime(int.parse(dateComponents[0]),int.parse(dateComponents[1]),int.parse(dateComponents[2]));
                      print("átállított után");
                      print(ref.read(availabilityFilterProvider.notifier).state);
                      print(arg.value.toString());
                    },
                ),
                Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...chooseTime.slots!.map((slot) {
                        return InkWell(
                          onTap: () {
                            pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(name: '/book'),
                              screen: chooseTime(),
                            );
                          },
                          child: Chip(
                            label: Text(slot.start.toString()),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                ),



              ]
            );
          },
          error: (e,_){return Text("hiba");},
          loading: (){return CircularProgressIndicator();}
      )*/
//endregion old implementation