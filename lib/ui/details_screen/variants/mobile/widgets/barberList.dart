import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../controllers/barber_controller/barber_providers.dart';
import '../details_screen_mobile.dart';
import 'barberHead.dart';

class BarberList extends ConsumerWidget {
  const BarberList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbersState = ref.watch(barberListForShopStateProvider);
    final barbersContent = ref.watch(barberListForShopContentProvider);

    return barbersState.when(
        data: (data) => data.isEmpty
            ? const Center(
                child: Text("sajnos nem tudtunk barbereket beszedeni"),
              )
            : Container(
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
                    }),
              ),
        error: (e, _) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
