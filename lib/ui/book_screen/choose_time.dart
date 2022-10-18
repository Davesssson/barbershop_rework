import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_providers.dart';
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../models/work_day_availability/work_day_availability_model.dart';

StateProvider<DateTime> selectedDate = StateProvider<DateTime>((_) => DateTime(2020));





class chooseTime extends ConsumerStatefulWidget {
  const chooseTime({Key? key, required this.barberId}) : super(key: key);
  final barberId;
  @override
  ConsumerState<chooseTime> createState() => _chooseTimeState();
}

class _chooseTimeState extends ConsumerState<chooseTime> {
  final List<DateTime> list = [];
  final List<Widget> chips = [];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 30; i++) {
      list.add(DateTime.now().add(Duration(days: i)));
    }
    super.initState();
  }

  void prepareBlackoutDates(List<WorkDayAvailability> data) {
    data.forEach((day) {
      final List<String> workDayString = day.id!.split("-");
      final DateTime workDayDateTime = DateTime(int.parse(workDayString[0]),
          int.parse(workDayString[1]), int.parse(workDayString[2]));
      print(workDayDateTime);
      list.removeWhere((element) {
        final List<String> dateInTheListString = element.toString().split(" ");
        final List<String> asd22 = dateInTheListString[0].toString().split("-");
        final date2 = DateTime(
            int.parse(asd22[0]), int.parse(asd22[1]), int.parse(asd22[2]));
        return date2 == workDayDateTime;
      });
    });
  }

  void displayNewChips(DateRangePickerSelectionChangedArgs arg) {
    final date = arg.value.toString().split(" ");
    final dateComponents = date[0].split("-");
    ref.read(WorkDayAvailabilityFilterProvider.notifier).state = DateTime(
        int.parse(dateComponents[0]),
        int.parse(dateComponents[1]),
        int.parse(dateComponents[2])
    );
    chips.clear();
    print("WorkDayAvailabilityFilterState = " +
        ref.read(WorkDayAvailabilityFilterProvider.notifier).state.toString());
  }

  List<Widget> prepareChipChoices(WorkDayAvailability availability) {
    if (availability.id != null) {
      List<Widget> temp = [];
      List<String> splitDate = availability.id!.split("-");
      DateTime start = DateTime(
          int.parse(splitDate[0]),
          int.parse(splitDate[1]),
          int.parse(splitDate[2]),
          int.parse(availability.start.toString().substring(0, 2)),
          int.parse(availability.start.toString().substring(2)));
      DateTime end = DateTime(
          int.parse(splitDate[0]),
          int.parse(splitDate[1]),
          int.parse(splitDate[2]),
          int.parse(availability.end.toString().substring(0, 2)),
          int.parse(availability.end.toString().substring(2)));
      for (start; start.isBefore(end);) {
        DateTime improved2 = start.add(Duration(minutes: 30));
        start = improved2;
        temp.add(
          CustomChip(ref: ref, start: start,barberId:widget.barberId),
        );
      }
      return temp;
    } else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    final workDayAvailabilityListState =
        ref.watch(WorkDayAvailabilityListStateProvider(widget.barberId));
    final workDayAvailabilityListContent =
        ref.watch(WorkDayAvailabilityListContentProvider(widget.barberId));

    return Scaffold(
        body: workDayAvailabilityListState.when(data: (data) {
      prepareBlackoutDates(data);
      return ListView(children: [
        SfDateRangePicker(
          initialSelectedDate:
              DateTime.parse(workDayAvailabilityListContent.id!),
          maxDate: DateTime.now().add(Duration(days: 30)),
          enablePastDates: false,
          allowViewNavigation: true,
          enableMultiView: false,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7,
            numberOfWeeksInView: 1,
            blackoutDates: [
              ...list,
            ],
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs arg) {
            print("inital date selected" + ref.read(selectedDate).toString());
            final date = arg.value.toString().split(" ");
            final dateComponents = date[0].split("-");
            int year = int.parse(dateComponents[0]);
            int month = int.parse(dateComponents[1]);
            int day = int.parse(dateComponents[2]);
            DateTime overrideWith = DateTime(year,month,day);
            ref.read(selectedDate.notifier).state=overrideWith;
            print("after changing date selected" +ref.read(selectedDate).toString());
            displayNewChips(arg);
          },
        ),
        Container(
          height: MediaQuery.of(context).size.height / 10,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [...prepareChipChoices(workDayAvailabilityListContent)],
          ),
        ),
      ]);
    }, error: (e, _) {
      return Text("asdasdasd");
    }, loading: () {
      return CircularProgressIndicator();
    }));
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.barberId,
    required this.ref,
    required this.start,
  }) : super(key: key);
  final String barberId;
  final WidgetRef ref;
  final DateTime start;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(ref.read(selectedDate).year==2020)return;
        print("helobelo");
        print(start.toString());
        final date = start.toString().split(" ")[0];
        final time = start.toString().split(" ")[1];
        final date_split = date.split("-");
        final time_split = time.split(":");
        int year = int.parse(date_split[0]);
        int month = int.parse(date_split[1]);
        int day = int.parse(date_split[2]);
        int hour = int.parse(time_split[0]);
        int minute = int.parse(time_split[1]);
        String startt = hour.toString()+minute.toString();
        print(date);
        print(barberId);
        print(int.parse(startt));
        ref.read(barberListForShopStateProvider.notifier).addBooking(
          dateId: date,
          uId: "uniqueId3",
          barberId: barberId,
          start: int.parse(startt),
          end:2000,
        );
      },
      child: Chip(
        label: Text("${start.hour}:${start.minute}")),
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
