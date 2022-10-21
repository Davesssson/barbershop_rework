import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/map_screen/map_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../controllers/infoWindow_controller/infoWindow_providers.dart';
import '../../controllers/service_controller/service_providers.dart';
import '../details_screen/details_screen.dart';

class infoWindow extends ConsumerWidget {
  const infoWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(cityFilterStateForMap);
    final shop = ref.watch(
        barbershopForMapStateProvider(selectedCity));

    return shop.when(
        data: (shop) {
            return Positioned(
                top: MediaQuery.of(context).size.height*0.6,
                //bottom : 0,
                //left:0,
                child: InkWell(
                  onTap: (){
                    ref.read(barberListForShopStateProvider.notifier).retrieveBarbersFromShop2(shop.id!);
                    ref.read(barberListStateProvider.notifier).retrieveBarbersFromShop2(shop.id!);
                    ref.read(serviceListForShopStateProvider.notifier).retrieveServicesFromShop(shop.id!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=>DetailsScreen(),
                        settings: RouteSettings(
                          arguments: shop,// TODO ez igy ebben a formában jo a materialRoutepage-el????
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(


                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/4.5,
                      color: Colors.red,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Text(shop.name!),
                              Text(shop.city!),
                            ],
                          ),
                          Column(
                            children: [
                              Container(height: MediaQuery.of(context).size.height/4.5,child: Image.network(shop.main_image!))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
          },

        error: (e, _) {
          return Text("maohiba");
        },
        loading: () {
          return CircularProgressIndicator();
        }
    );
  }
}