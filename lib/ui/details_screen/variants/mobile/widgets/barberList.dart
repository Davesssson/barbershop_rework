import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../../models/barbershop/barbershop_model.dart';
import '../details_screen_mobile.dart';
import 'barberHead.dart';

class BarberList extends ConsumerWidget {
  const BarberList({
    Key? key,
    required this.bs,
  }) : super(key: key);
  final Barbershop bs;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbersState = ref.watch(barberListForShopStateProvider(bs!.id!));

    return barbersState.when(
        data: (data) => data.isEmpty
            ? const Center(
                child: Text("sajnos nem tudtunk barbereket beszedeni"),
              )
            : Align(
              alignment: Alignment.center,
              child: Container(
                  height: 151,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final barber = data[index];
                        return ProviderScope(
                            overrides: [currentBarber.overrideWithValue(barber)],
                            child: BarberHead(barber: barber));
                      }),
                ),
            ),
        error: (e, _) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
