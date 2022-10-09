
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../controllers/timeslot/timeslot_controller.dart';
import '../../controllers/timeslot/timeslot_providers.dart';
import '../../models/availability/availability_model.dart';

class chooseTime extends ConsumerStatefulWidget{
  const chooseTime({Key? key}):super(key:key);

  @override
  ConsumerState<chooseTime> createState()=>_chooseTimeState();
}


class _chooseTimeState extends ConsumerState<chooseTime> {

  final  List<DateTime> list =[];

  @override
  void initState() {
    // TODO: implement initState
    for(int i =0;i<30;i++){
      list.add(DateTime.now().add(Duration(days:i)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(AvailabilityListStateProvider);
    final barbersState = ref.watch(barberListForShopStateProvider);
    final barbersContent = ref.watch(barberListForShopContentProvider);
    final chooseTime = ref.watch(AvailabilityListContentProvider);
    
    return Scaffold(
      body:details.when(
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
                        ...list
/*                        ...data.map((e) { // ide még kell egy csekk, hogy csak akkor legyen engedélyezett hogyha van szabad timeslot
                          final asd = e.id!.split("-");
                          print(asd);
                          return DateTime(int.parse(asd[0]),int.parse(asd[1]),int.parse(asd[2]));
                        }).toList()*/
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
/*                          onTap: () {
                            pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(name: '/book'),
                              screen: chooseTime(),
                            );
                          },*/
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
      )
    );
  }


}

