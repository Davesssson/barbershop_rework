import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class calendarScreen extends ConsumerWidget {
  calendarScreen({Key? key}) : super(key: key);
  static CalendarController _controller = CalendarController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,// Monday
        showNavigationArrow: true,
        cellEndPadding: 5,
        allowedViews: [
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.timelineDay,
          CalendarView.timelineWeek,
          CalendarView.timelineWorkWeek
        ],
        //viewHeaderStyle:
        //ViewHeaderStyle(backgroundColor: viewHeaderColor),
        controller: _controller,
        onTap: (CalendarTapDetails details){
          final Appointment appointmentDetails = details.appointments![0];
          buildShowDialog(context, appointmentDetails, details);

        },
        dataSource: _getCalendarDataSource(),
        initialDisplayDate: DateTime.now(),
        //dataSource: getCalendarDataSource(),
        //onTap: calendarTapped,
        monthViewSettings: MonthViewSettings(
            navigationDirection: MonthNavigationDirection.horizontal),
      ),
    );

  }

  Future<dynamic> buildShowDialog(BuildContext context, Appointment appointmentDetails, CalendarTapDetails details) {
    return showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Container(child: new Text(appointmentDetails.subject)),
                content: Container(
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            details.date.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                   TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text('close'))
                ],
              );
            });
  }
  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime:DateTime.now().add(Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.blue,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
      subject: 'Planning',
      color: Colors.green,
    ));

    return _AppointmentDataSource(appointments);
  }

}
class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}