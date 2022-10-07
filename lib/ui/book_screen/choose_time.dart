
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../controllers/timeslot/timeslot_controller.dart';
import '../../controllers/timeslot/timeslot_providers.dart';
import '../../models/availability/availability_model.dart';

class chooseTime extends ConsumerWidget {
  const chooseTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(AvailabilityListStateProvider);
    final barbersState = ref.watch(barberListForShopStateProvider);
    final barbersContent = ref.watch(barberListForShopContentProvider);
    final chooseTime = ref.watch(AvailabilityListContentProvider);
    
    List<DateTime> list = [];
    
    
    return Scaffold(
      body:details.when(
          data: (data) {
            
            return ListView(
              children:[
                  SfDateRangePicker(
                    enablePastDates: false,
                    allowViewNavigation: true,
                    enableMultiView: false,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      firstDayOfWeek: 7,
                      numberOfWeeksInView: 1,
                      blackoutDates:[
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
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  color: Colors.green,
                  child: Text(chooseTime.slots!.length.toString()),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                )
              ]
            );
          },
          error: (e,_){return Text("hiba");},
          loading: (){return CircularProgressIndicator();}
      )
    );
  }

/*  void queryBlackoutDates(List<Availability> details ){
    DateTime today = DateTime.now();
    details.map((timeslot) {
      if(DateTime(timeslot.id))
    });*/


  }

