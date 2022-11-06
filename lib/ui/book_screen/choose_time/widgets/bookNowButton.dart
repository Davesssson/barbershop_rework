
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../models/barbershop/barbershop_model.dart';
import '../../../../models/booking/booking_model.dart';
import '../../../../repositories/booking_repository.dart';
import '../../../../repositories/user_repository.dart';
import '../choose_time.dart';

class bookNowButton extends ConsumerWidget {
  const bookNowButton({
    Key? key,
    required this.barbershop,
    required this.barberId,
  }) : super(key: key);

  final Barbershop barbershop;
  final String barberId;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedService = ref.watch(selectedServiceProvider);
    final chipSelected = ref.watch(selectedChip);

    return Center(
      child: ElevatedButton(
        child: Text("BOOK NOW",),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: chipSelected!=null ? () {
          //if(ref.read(selectedDate).year==2020)return;

          User? user = ref.watch(authControllerProvider);

          if(user!.isAnonymous ) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).cardColor,
              useRootNavigator: false,
              builder: (context) => Center(
                child: Column(
                  children: [
                    Text("Ahhoz, hogy tudj foglalni be kell jelentkezned testvérem..."),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Exit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(selectedService!="") {
            final date = chipSelected.start.toString().split(" ")[0];
            final time = chipSelected.start.toString().split(" ")[1];
            final date_split = date.split("-");
            final time_split = time.split(":");
            int year = int.parse(date_split[0]);
            int month = int.parse(date_split[1]);
            int day = int.parse(date_split[2]);
            int hour = int.parse(time_split[0]);
            int minute = int.parse(time_split[1]);
            String startt = hour.toString() + minute.toString();
            print(date);
            print(barberId);
            print(int.parse(startt));
            Uuid uuid = Uuid();


            Booking b = Booking(
                dateId: date,
                uId: uuid.v4(),
                barberId: barberId!,
                start: int.parse(startt),
                userReserverId: user!.uid,
                serviceId: selectedService
            );

            ref.read(barberListForShopStateProvider(barbershop!.id!).notifier).addBooking(
                dateId: b.dateId!,
                uId: b.uId!,
                barberId: barberId,
                start: b.start!,
                end: 2000,
                userReserverId: user!.uid,
                serviceId: selectedService!
            );
            ref.read(userRepositoryProvider).addBookingToUser(user, b.uId!);
            ref.read(BookingRepositoryProvider).addBooking(booking: b);

            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.grey,
              useRootNavigator: false,
              builder: (context) =>
                  Center(
                    child: Column(
                      children: [
                        Text("sikeres foglalás ${barbershop
                            .name}ügyes vagy"),
                        Text("INSERT BARBERSHOP HERE"),
                        Text("INSERT BARBER NAME -hez"),
                        Text("INSERT ${chipSelected.start} TIME -ra"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .popAndPushNamed(
                                '/home'); //majd a detailsre vigyen át
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
          };
        }:null,

      ),
    );
  }
}
