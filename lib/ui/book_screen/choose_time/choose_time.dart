import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/work_day_availability_controller/work_day_availability_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../controllers/service_controller/service_providers.dart';
import '../../../models/barbershop/barbershop_model.dart';
import '../../../models/work_day_availability/work_day_availability_model.dart';
import '../choose_barber/widgets/custom_chip.dart';
import 'widgets/bookNowButton.dart';
import 'widgets/servicesList.dart';

StateProvider<DateTime> selectedDate = StateProvider<DateTime>((_) => DateTime(2020));
StateProvider<CustomChip?> selectedChip = StateProvider<CustomChip?>((_) => null);
StateProvider<String?> selectedServiceProvider = StateProvider<String?>((_) => "");


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
    final services = ref.watch(servicesForShopProvider(widget.barbershop.id!));
    final selectedService = ref.watch(selectedServiceProvider);

    return Scaffold(
        body: workDayAvailabilityListState.when(data: (data) {
      prepareBlackoutDates(data);
      return ListView(children: [
        SizedBox(height: 20,),
        Text("Válassz dátumot!"),
        SfDateRangePicker(
          backgroundColor: Theme.of(context).cardColor,
          selectionColor: Theme.of(context).primaryColor,
          showNavigationArrow: true,
          initialSelectedDate: null,
          maxDate: DateTime.now().add(Duration(days: 30)),
          enablePastDates: false,
          allowViewNavigation: true,
          enableMultiView: false,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7,
            numberOfWeeksInView: 4,
            blackoutDates: [
              ...list,
            ],
          ),
          onSelectionChanged: onCalendarSelectionChangedCallback
        ),
        SizedBox(height: 30,),
        Text("Válassz az elérhető időpontok közül!"),
        SizedBox(height: 30,),
        Container(color:Theme.of(context).cardColor,child: buildChipChoicesGridView(context, workDayAvailabilityListContent)),
        SizedBox(height: 30,),
        Text("Szolgáltatások"),
        SizedBox(height: 30,),
        servicesList(barbershopId: widget.barbershop.id!),
        bookNowButton(barbershop: widget.barbershop, barberId: widget.barberId,),
        SizedBox(height: 100,)
        //TODO IDE MÉG A SZOLGÁLTATÁSOKAT
      ]);
    }, error: (e, _) {
      return Text("asdasdasd");
    }, loading: () {
      return CircularProgressIndicator();
    }));
  }

  GridView buildChipChoicesGridView(BuildContext context, WorkDayAvailability workDayAvailabilityListContent) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      crossAxisCount: (MediaQuery.of(context).size.width / 70).toInt(),
      children: prepareChipChoices(workDayAvailabilityListContent),
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
      DateTime start ;
      if(availability.start.toString().length==3){
        final hour = int.parse(availability.start.toString()[0]);
        final minute = int.parse(availability.start.toString().substring(1));
        start = DateTime(
          int.parse(splitDate[0]),
          int.parse(splitDate[1]),
          int.parse(splitDate[2]),
          hour,
          minute
        );
      }else{
        final hour = int.parse(availability.start.toString().substring(0,1));
        final minute = int.parse(availability.start.toString().substring(2));
        start = DateTime(
            int.parse(splitDate[0]),
            int.parse(splitDate[1]),
            int.parse(splitDate[2]),
            hour,
            minute
        );
      }
      print("ezt kell nezni start = "+start.toString());
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

  void onCalendarSelectionChangedCallback(DateRangePickerSelectionChangedArgs arg) {
    print("inital date selected" + ref.read(selectedDate).toString());
    updateDateSelected(arg, ref);
    displayNewChips(arg);
    ref.read(selectedChip.notifier).state=null;
    ref.read(selectedServiceProvider.notifier).state=null;
  }

}
