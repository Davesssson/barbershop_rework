
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../../../controllers/service_controller/service_providers.dart';
import '../../../../../../models/barbershop/barbershop_model.dart';

class ShopTileWebSmall extends ConsumerWidget {
  const ShopTileWebSmall({
    Key? key,
    required this.barbershop,
  }) : super(key: key);

  final Barbershop barbershop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: (){
        ref.read(barberListForShopStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
        ref.read(barberListStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
        ref.read(serviceListForShopStateProvider.notifier).retrieveServicesFromShop(barbershop.id!);
        GoRouter.of(context).go("/details/${barbershop.id}");
      },
      child: Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.width/6,
        width: MediaQuery.of(context).size.width/6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.width/8.5,
              width: MediaQuery.of(context).size.width/8.5,
              child: Image.network(barbershop.main_image!,fit: BoxFit.fitHeight,),
            ),
            Text(barbershop.name!),
            Text(barbershop.city!),

          ],
        ),
      ),
    );
  }
}