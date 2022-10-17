import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../models/barber/barber_model.dart';

class calendarView extends ConsumerWidget {
  const calendarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberState = ref.watch(barberListForShopStateProvider);

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: _getCalendarDataSource(barberState),
      resourceViewSettings: ResourceViewSettings(
          visibleResourceCount: 4,
          size: 150,
          displayNameTextStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15,
              fontWeight: FontWeight.w400
          )
      ),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}

DataSource _getCalendarDataSource(AsyncValue<List<Barber>> state) {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];
  state.when(
      data: (data){
        data.isEmpty
          ? {}
          : data.forEach((barber) {
            resources.add(
                CalendarResource(
                  id: barber.id!,
                  displayName: barber.name!,
                )
            );
          });

      },
      error: (e,_){},
      loading: (){}
  );

  appointments.add(
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 2)),
      isAllDay: false,
      subject: 'Meeting',
      color: Colors.blue,
      resourceIds: <Object>['0001'],
    ),
  );
  appointments.add(
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 6)),
      isAllDay: false,
      subject: 'Meeting',
      color: Colors.red,
      resourceIds: <Object>['0001'],
    ),
  );

  resources.add(CalendarResource(displayName: 'John', id: '0001', color: Colors.red));

  return DataSource(appointments, resources);
}

