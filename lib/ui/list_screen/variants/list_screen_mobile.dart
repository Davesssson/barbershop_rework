import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barbershop_controller.dart';


class ListScreen_mobile extends ConsumerWidget {
  const ListScreen_mobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershopListState = ref.watch(BarbershopListControllerProvider);
    final filteredBarbershopList = ref.watch(filteredBarbershopListProvider);
    return Scaffold(
        body: barbershopListState.when(
            data: (items) => items.isEmpty
                ? const Center(
                    child: Text(
                      'Sajnos nincsen megjeleníthető üzlet',
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredBarbershopList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = filteredBarbershopList[index];
                      return Container(
                        color: Colors.purple,
                        child: Column(
                          children: [
                            Text(item.name!),
                            Text(item.main_image!),
                            Text(item.places_id!),
                            Row(
                              children: [
                              Text(item.location.longitude.toString()),
                              Text(item.location.latitude.toString()),
                              ],
                            ),
                            Text("------")


                          ],
                        ),
                      );
                    },
                  ),
            error: (error,_)=>Text("error"),
            loading:() => const Center(child: CircularProgressIndicator()))
    );
  }
}
