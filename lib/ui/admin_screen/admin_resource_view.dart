import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../controllers/resource_view_controller/resource_view_providers.dart';
import '../../controllers/service_controller/service_providers.dart';
import '../../models/resource_view_model/resource_view_model.dart';

class calendarView extends ConsumerWidget {
  final String shopId;
  const calendarView({
    required this.shopId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resViewState = ref.watch(resourceViewListStateProvider(shopId));

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: _getCalendarDataSource(resViewState,ref),
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

DataSource _getCalendarDataSource(AsyncValue<List<ResourceViewModel>> state, WidgetRef ref) {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];
  state.when(
      data: (resourceModels){
        resourceModels.isEmpty
          ? {}
          : resourceModels.forEach((resource) {
            print("current resource = "+resource.toString() );
            resources.add(
                CalendarResource(
                  color:Colors.cyan,
                  id: resource.barber!.id!,
                  displayName: resource.barber!.name!,
                )
            );
            if(resource.workDayAvailability != null) {
              resource.workDayAvailability!.forEach((availability) {
                int year = int.parse(availability.id.toString().split("-")[0]);
                int month = int.parse(availability.id.toString().split("-")[1]);
                int day = int.parse(availability.id.toString().split("-")[2]);
                int startHour = int.parse(
                    availability.start.toString().substring(0, 2));
                int startMinute = int.parse(
                    availability.start.toString().substring(2));
                int endHour = int.parse(
                    availability.end.toString().substring(0, 2));
                int endMinute = int.parse(
                    availability.end.toString().substring(2));
                appointments.add(
                  Appointment(
                    startTime: DateTime(
                        year, month, day, startHour, startMinute),
                    endTime: DateTime(year, month, day, endHour, endMinute),
                    isAllDay: false,
                    subject: resource.barber!.name!+" Dolgozik ",
                    color: Colors.blue,
                    resourceIds: <Object>[resource.barber!.id!],
                  ),
                );
              });
            }else {print("ures voltam");}

            if(resource.bookings != null) {
              resource.bookings!.forEach((booking) {
                booking.bookings!.forEach((oneBooking) {
                  int year = int.parse(oneBooking.dateId.toString().split("-")[0]);
                  int month = int.parse(oneBooking.dateId.toString().split("-")[1]);
                  int day = int.parse(oneBooking.dateId.toString().split("-")[2]);
                  int startHour = int.parse(
                      oneBooking.start.toString().substring(0, 2));
                  int startMinute = int.parse(
                      oneBooking.start.toString().substring(2));
                  int endHour = int.parse(
                      oneBooking.end.toString().substring(0, 2));
                  int endMinute = int.parse(
                      oneBooking.end.toString().substring(2));
                  appointments.add(
                    Appointment(
                      startTime: DateTime(
                          year, month, day, startHour, startMinute),
                      endTime: DateTime(year, month, day, endHour, endMinute),
                      isAllDay: false,
                      subject: ref.watch(userNanemFromIdProvider(oneBooking.userReserverId!)).when(
                          data: (data) {return data;},
                          error: (e,_){return "faszomat márr";},
                          loading: (){return "loading";}
                      ),
                      notes: oneBooking.serviceId=="" ? ref.watch(singleServiceProvider(oneBooking.serviceId!)).when(
                          data: (data){return data.serviceTitle!;},
                          error: (e,_){return "Error a szolgáltatás beszedésnél";},
                          loading: (){return "loading";}
                      ):"asd"
                      ,
                      color: Colors.purple,
                      resourceIds: <Object>[resource.barber!.id!],
                    ),
                  );
                });
              });
            }else {print("ures bookings voltam");}



          });

      },
      error: (e,_){},
      loading: (){}
  );


  resources.add(CalendarResource(displayName: 'John', id: '0001', color: Colors.red));

  return DataSource(appointments, resources);
}

