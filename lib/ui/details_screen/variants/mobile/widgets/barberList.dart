import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../../models/barbershop/barbershop_model.dart';
import '../details_screen_mobile.dart';
import 'barberHead.dart';


class BarberList extends ConsumerWidget {
  const BarberList({
    Key? key,
    required this.barbershop,
  }) : super(key: key);

  final Barbershop barbershop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barbersContent = ref.watch(barberListForShopContentProvider);

    return Container(
      height: 151,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: barbersContent.length,
          itemBuilder: (BuildContext context, int index) {
            final barber = barbersContent[index];
            //return Text(barber.name!);
            return ProviderScope(
                overrides: [currentBarber.overrideWithValue(barber)],
                child: BarberHead(barber: barber));
          }
      ),
    );
  }
}

