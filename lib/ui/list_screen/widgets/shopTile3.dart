import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';
import '../../../models/barbershop/barbershop_model.dart';
import '../../details_screen/details_screen.dart';

class ShopTile3 extends HookConsumerWidget {

  const ShopTile3({required this.shopToWatch,Key? key}) : super(key: key);
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_)=>DetailsScreen(),
              settings: RouteSettings(
                arguments: barbershop,// TODO ez igy ebben a formában jo a materialRoutepage-el????
              ),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height/3,
          width:MediaQuery.of(context).size.width*0.85,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: (
              Stack(
                children: [
                  Center(
                    child: Image.network(
                      barbershop.main_image!,
                      fit:BoxFit.contain,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black,Colors.transparent]
                      )
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 30,
                    child: Text(
                      barbershop.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}