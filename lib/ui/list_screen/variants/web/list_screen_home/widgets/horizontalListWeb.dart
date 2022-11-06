
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../controllers/barbershop_controller/barbershop_providers.dart';
import 'shopTileBigWeb.dart';

class HorizontalListWeb extends ConsumerWidget{
  const HorizontalListWeb({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = ref.watch(barbershopListStateProvider);
    final contentProvider = ref.watch(barbershopListContentProvider);
    return stateProvider.when(
        data: (data){
          return data.isEmpty
              ? SizedBox(height: 100, child: Text("Sanjnos nincsen adat a horizontalList-ben"),)
              : SizedBox(
            //height: MediaQuery.of(context).size.height/3.2,
                height: MediaQuery.of(context).size.width/6,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: contentProvider.length,
                  separatorBuilder: (context, index){
                    return const SizedBox(width: 20);
                  },
                  itemBuilder: (context, index) {
                    final barbershop = contentProvider[index];
                    return ShopTileWebBig(barbershop: barbershop);
                    //return ShopTileWebSmall(barbershop: barbershop);
                  },
                ),
          );
        },
        error: (error,_)=>Text("errpr in details screen"),
        loading: () => const Center(child: CircularProgressIndicator())
    );
  }

}