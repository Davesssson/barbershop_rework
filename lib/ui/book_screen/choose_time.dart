import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_providers.dart';
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_providers.dart';
import 'package:flutter_shopping_list/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import '../../models/barbershop/barbershop_model.dart';
import '../../models/booking/booking_model.dart';
import '../../models/work_day_availability/work_day_availability_model.dart';
import '../../repositories/booking_repository.dart';
import 'widgets/custom_chip.dart';

StateProvider<DateTime> selectedDate = StateProvider<DateTime>((_) => DateTime(2020));
StateProvider<CustomChip?> selectedChip = StateProvider<CustomChip?>((_) => null);

class chooseTime extends ConsumerStatefulWidget {
  const chooseTime({Key? key, required this.barberId,required this.barbershop}) : super(key: key);
  final barberId;
  final Barbershop barbershop;
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

  @override
  Widget build(BuildContext context) {
    final workDayAvailabilityListState =
        ref.watch(WorkDayAvailabilityListStateProvider(widget.barberId));
    final workDayAvailabilityListContent =
        ref.watch(WorkDayAvailabilityListContentProvider(widget.barberId));
    final chipSelected = ref.watch(selectedChip);

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
            updateDateSelected(arg, ref);
            displayNewChips(arg);
            ref.read(selectedChip.notifier).state=null;
          },
        ),
        buildChipChoicesGridView(context, workDayAvailabilityListContent),//TODO itt dobja a render errort, majd később foglalkozok vele
        Center(
          child: ElevatedButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPressed: chipSelected!=null ? () {
              if(ref.read(selectedDate).year==2020)return;
              final date = chipSelected.start.toString().split(" ")[0];
              final time = chipSelected.start.toString().split(" ")[1];
              final date_split = date.split("-");
              final time_split = time.split(":");
              int year = int.parse(date_split[0]);
              int month = int.parse(date_split[1]);
              int day = int.parse(date_split[2]);
              int hour = int.parse(time_split[0]);
              int minute = int.parse(time_split[1]);
              String startt = hour.toString()+minute.toString();
              print(date);
              print(widget.barberId);
              print(int.parse(startt));
              Uuid uuid = Uuid();
              User? user = ref.watch(authControllerProvider);
              Booking b = Booking(
                  dateId: date,
                  uId: uuid.v4(),
                  barberId: widget.barberId!,
                  start:int.parse(startt),
                  userReserverId: user!.uid
              );

              ref.read(barberListForShopStateProvider.notifier).addBooking(
                dateId: b.dateId!,
                uId: b.uId!,
                barberId: widget.barberId,
                start: b.start!,
                end:2000,
                userReserverId:user!.uid
              );
              ref.read(userRepositoryProvider).addBookingToUser(user,b.uId!);
              ref.read(BookingRepositoryProvider).addBooking(booking: b);

              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey,
                useRootNavigator: false,
                builder: (context) => Center(
                  child: Column(
                    children: [
                      Text("sikeres foglalás ${widget.barbershop.name}ügyes vagy"),
                      Text("INSERT BARBERSHOP HERE"),
                      Text("INSERT BARBER NAME -hez"),
                      Text("INSERT ${chipSelected.start} TIME -ra"),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).popAndPushNamed('/home'); //majd a detailsre vigyen át
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }:null,
            child: Text(
              "BOOK NOW ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]);
    }, error: (e, _) {
      return Text("asdasdasd");
    }, loading: () {
      return CircularProgressIndicator();
    }));
  }

  Flexible buildChipChoicesGridView(BuildContext context, WorkDayAvailability workDayAvailabilityListContent) {
    return Flexible(
        //height: MediaQuery.of(context).size.height/5,
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: (MediaQuery.of(context).size.width / 70).toInt(),
          children: prepareChipChoices(workDayAvailabilityListContent),
        ),
      );
  }

  Container buildChipChoicesScrollView(BuildContext context, WorkDayAvailability workDayAvailabilityListContent) {
    return Container(
        height: MediaQuery.of(context).size.height / 10,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: prepareChipChoices(workDayAvailabilityListContent),
        ),
      );
  }

  void updateDateSelected(DateRangePickerSelectionChangedArgs arg, WidgetRef ref) {
    final date = arg.value.toString().split(" ");
    final dateComponents = date[0].split("-");
    int year = int.parse(dateComponents[0]);
    int month = int.parse(dateComponents[1]);
    int day = int.parse(dateComponents[2]);
    DateTime overrideWith = DateTime(year,month,day);
    ref.read(selectedDate.notifier).state=overrideWith;
    print("after changing date selected" +ref.read(selectedDate).toString());
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

}
