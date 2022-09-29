import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/service_controller/service_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/barber_controller/barber_controller.dart';
import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../models/barbershop/barbershop_model.dart';
import '../../details_screen/details_screen.dart';

class ShopTile2 extends HookConsumerWidget {

  const ShopTile2({required this.shopToWatch,Key? key}) : super(key: key);
  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(shopToWatch);
    return Card(
      color:Colors.grey,
      clipBehavior: Clip.antiAlias,
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
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(barbershop.main_image!)),
              title: Text(barbershop.name!,style: TextStyle(color: Colors.white70),),
              key: ValueKey(barbershop.id),
              subtitle: Text(
                "secondary",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),

            Container(
                width: double.infinity,
                child: Image.network(barbershop.main_image!,height: MediaQuery.of(context).size.height/4.5,fit: BoxFit.cover,))
            //Image.asset('assets/card-sample-image-2.jpg'),
          ],
        ),
      ),
    );
  }
}



class ShopTile extends HookConsumerWidget {

  const ShopTile({required this.shopToWatch,Key? key}) : super(key: key);
  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(shopToWatch);
    return Card(
      color:Colors.grey,
      clipBehavior: Clip.antiAlias,
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
          width:MediaQuery.of(context).size.width*0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(barbershop.main_image!)),
                title: Text(barbershop.name!,style: TextStyle(color: Colors.white70),),
                key: ValueKey(barbershop.id),
                subtitle: Text(
                  "secondary",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),

              Container(
                height: 500,

                  width:500,
                  child: Image.network(barbershop.main_image!,height: MediaQuery.of(context).size.height/4.5,fit: BoxFit.cover,))
              //Image.asset('assets/card-sample-image-2.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}
