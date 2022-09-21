import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barber_controller/barbershop_controller.dart';


class ListScreen_mobile2 extends ConsumerWidget {
  const ListScreen_mobile2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershopListState = ref.watch(barbershopListStateProvider);
    final filteredBarbershopList = ref.watch(barbershopListContentProvider);
    return Scaffold(
        body: ref.watch(barberListStateProvider).when(
            data: (items)=>items.isEmpty
              ? const Center(
                child: Text(
                  'Sajnos a berberek megbaszódtak',
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              )
            :ListView.builder(
              itemCount: ref.watch(barberListContentProvider).length,
              itemBuilder: (BuildContext context, int index){
                final barber = ref.watch(barberListContentProvider)[index];
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
