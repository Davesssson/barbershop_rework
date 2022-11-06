

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../controllers/barbershop_controller/barbershop_controller.dart';
import '../../../../../models/barbershop/barbershop_model.dart';
import '../../../widgets/shopTile3.dart';

class HorizontalList2 extends ConsumerWidget{
  const HorizontalList2({
    Key? key,

    required this.shopToWatch,
  }) : super(key: key);


  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = ref.watch(barbershopGeoqueryProvider);
    return stateProvider.when(
        data: (data){
          return data.isEmpty
              ? SizedBox(height: 100, child: Text("Sanjnos nincsen adat a horizontalList-ben"),)
              : SizedBox(
            height: MediaQuery.of(context).size.height/3.2,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              separatorBuilder: (context, index){
                return const SizedBox(width: 20);
              },
              itemBuilder: (context, index) {
                final barbershop = data[index];
                return ProviderScope(
                    overrides: [shopToWatch.overrideWithValue(barbershop)],
                    child: ShopTile3(shopToWatch:shopToWatch)
                );
              },
            ),
          );
        },
        error: (error,_)=>Text("errpr in details screen"),
        loading: () => const Center(child: CircularProgressIndicator())
    );
  }

}