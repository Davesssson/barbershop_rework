import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/constants/route_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';
import '../../../models/barbershop/barbershop_model.dart';
import '../../details_screen/details_screen.dart';

class ShopTile4 extends HookConsumerWidget {

  const ShopTile4({required this.shopToWatch,Key? key}) : super(key: key);
  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(shopToWatch);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          ref.read(barberListForShopStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
          ref.read(barberListStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
          ref.read(serviceListForShopStateProvider.notifier).retrieveServicesFromShop(barbershop.id!);
          GoRouter.of(context).go("/details/${barbershop.id}");
          /*          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_)=>DetailsScreen(),
              settings: RouteSettings(
                arguments: barbershop,// TODO ez igy ebben a formában jo a materialRoutepage-el????
              ),
            ),
          );*/
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: MediaQuery.of(context).size.width*0.5,
            //width:MediaQuery.of(context).size.width*0.6,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height/4.5,
                    child: Image.network(barbershop.main_image!,fit: BoxFit.fitHeight,)),
                ListTile(
                  title:  Text(barbershop.name!),
                  subtitle: Text(
                    barbershop.city!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}