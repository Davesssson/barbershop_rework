import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/booking_controller/booking_providers.dart';

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
                    ...bookings.map((e) => Text(e.uId.toString()))
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
