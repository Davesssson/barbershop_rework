import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barber_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barbershop_controller.dart';


class ListScreen_mobile2 extends ConsumerWidget {
  const ListScreen_mobile2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershopListState = ref.watch(BarbershopListControllerProvider);
    final filteredBarbershopList = ref.watch(filteredBarbershopListProvider);
    return Scaffold(
        body: ref.watch(BarberListControllerProvider).when(
            data: (items)=>items.isEmpty
              ? const Center(
                child: Text(
                  'Sajnos a berberek megbaszódtak',
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              )
            :ListView.builder(
              itemCount: ref.watch(filteredBarberListProvider).length,
              itemBuilder: (BuildContext context, int index){
                final barber = ref.watch(filteredBarberListProvider)[index];
                return Container(
                  color: Colors.red,
                  child: Text(barber.name!),
                );
              }
            ),
            error: (error,_)=>Text("error a barberrel"),
            loading: () => const Center(child: CircularProgressIndicator())

        )
    );
  }
}
