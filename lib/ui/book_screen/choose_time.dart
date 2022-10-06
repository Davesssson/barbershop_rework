
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../models/availability/availability_model.dart';

class chooseTime extends ConsumerWidget {
  const chooseTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(availabilityProvider);
    final barbersState = ref.watch(barberListForShopStateProvider);
    final barbersContent = ref.watch(barberListForShopContentProvider);
    
    List<DateTime> list = [];
    
    
    return Scaffold(
      body:details.when(
          data: (data) {
            
            return ListView(
              children:[
                  SfDateRangePicker(
                    enablePastDates: false,
                    enableMultiView: false,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                        blackoutDates:[
                          ...data.map((e) { // ide még kell egy csekk, hogy csak akkor legyen engedélyezett hogyha van szabad timeslot
                            final asd = e.id!.split("-");
                            print(asd);
                            return DateTime(int.parse(asd[0]),int.parse(asd[1]),int.parse(asd[2]));
                          }).toList()
                        ]
                    ),
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

