import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/barber_controller/barber_providers.dart';
import '../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../controllers/booking_controller/booking_providers.dart';
import '../../models/barber/barber_model.dart';
import '../../models/booking/booking_model.dart';

class ownBookings extends ConsumerWidget {
  const ownBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final bookings = ref.watch(retrieveBookingsForUserProvider(authControllerState!.uid));

    return Scaffold(
      body: bookings.when(
          data: (bookings){
            return bookings.isEmpty
                ?Text("No bookings sofar")
                :Container(
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...bookings.map((oneBooking) {
                        return OwnBookingRow(b: oneBooking);
                    })
                  ],
                ),
              ),
            );
          },
          error: (e,_st){return Text("hiba");},
          loading: (){return CircularProgressIndicator();}
      )
    );
  }
}

class OwnBookingRow extends ConsumerWidget {
  final Booking b;
  const OwnBookingRow({Key? key, required this.b}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  barbershop = ref.watch(shopProvider("7HTJ8DF8hFwUnrL566Wc"));
    final  barber = ref.watch(retrieveSingleBarber(b.barberId!));

    return barbershop.when(
        data: (bs){
          return barber.when(
              data: (barberr){
                return ListTile(
                  leading: Image.network(bs.main_image!),
                  title: Text(bs.name!),
                  subtitle: Text(barberr.name!),
                  trailing: Column(
                    children: [
                      Text(b.dateId!), //ez nem tudom mi a faszt csinál, de amugy jó lesz
                      Text(b.start!.toString()),
                    ],
                  ),
                );
              },
              error: (e,_){return Text("Habár a shop betöltődött, a barber nem");},
              loading: (){return CircularProgressIndicator();}
          );
        },
        error: (e,_){return Text("nem sikerült a barbershopot betölteni"); },
        loading: (){return CircularProgressIndicator();}
    );

  }
}

