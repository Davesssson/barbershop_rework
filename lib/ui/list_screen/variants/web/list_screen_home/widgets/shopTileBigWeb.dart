
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../../../controllers/service_controller/service_providers.dart';
import '../../../../../../models/barbershop/barbershop_model.dart';

class ShopTileWebBig extends ConsumerWidget {
  const ShopTileWebBig({
    Key? key,
    required this.barbershop,
  }) : super(key: key);

  final Barbershop barbershop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: (){
        ref.read(barberListForShopStateProvider(barbershop.id!).notifier).retrieveBarbersFromShop2(barbershop.id!);
        //ref.read(barberListStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
        ref.read(serviceListForShopStateProvider.notifier).retrieveServicesFromShop(barbershop.id!);
        GoRouter.of(context).go("/details/${barbershop.id}");
      },
      child: Container(
        color: Theme.of(context).cardColor,
        height: MediaQuery.of(context).size.width/4,
        width: MediaQuery.of(context).size.width/3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.width/8,
              width: MediaQuery.of(context).size.width/3,
              child: Image.network(barbershop.main_image!,fit: BoxFit.fitWidth,),
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text(barbershop.name!,style: TextStyle(fontSize: 25),),
                    Text(barbershop.city!,style: TextStyle(fontSize: 15)),
                  ],
                ),
                Text("KIEMELT")
              ],
            )


          ],
        ),
      ),
    );
  }
}