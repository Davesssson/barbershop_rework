import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_providers.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_providers.dart';
import 'package:flutter_shopping_list/ui/list_screen/widgets/servicesList_desktop.dart';
import 'package:flutter_shopping_list/ui/map_screen/map_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';


//https://www.etsy.com/?ref=lgo

final homePageProvider = StateProvider<int>((_) => 0);


class ListScreen_web extends ConsumerWidget {
  ListScreen_web({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final page = ref.watch(homePageProvider);
    final int _selectedDestination = ref.watch(homePageProvider);

    List<Widget> _buildScreens(){
      return [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 60),
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(color:Colors.red, height: 300,child: Center(child: ServicesListDesktop()),),
                Text("Featured shops for you"),
                HorizontalListWeb()

              ],
            ),
          ),
        ),
        MapScreen()

      ];
    }

   return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.hail_rounded),
        toolbarHeight: 100,
        flexibleSpace: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: TextFormField(

                      )
                  ),
                  Text("sign in")
                ],
              ),
            ),
            Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: (){
                          ref.read(homePageProvider.notifier).state=0;
                        },
                        child: Text("Böngéssz üzletek között!")
                    ),
                    TextButton(
                        onPressed: (){ref.read(homePageProvider.notifier).state=1;},
                        child: Text("Nézd meg térképen")
                    ),
                    TextButton(
                        onPressed: (){},
                        child: Text("Fedezd fel!")
                    ),
                    TextButton(
                        onPressed: (){},
                        child: Text("Légy partner!")
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: _buildScreens()[page]
    );



  }
}

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
                  },
                ),
              );
        },
        error: (error,_)=>Text("errpr in details screen"),
        loading: () => const Center(child: CircularProgressIndicator())
    );
  }

}