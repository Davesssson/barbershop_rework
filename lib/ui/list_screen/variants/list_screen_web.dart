import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_providers.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_providers.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/list_screen/widgets/servicesList_desktop.dart';
import 'package:flutter_shopping_list/ui/map_screen/map_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';
import '../../admin_screen/admin_register.dart';
import '../../explorer_screen/variants/explorer_screen_mobile.dart';
import '../../explorer_screen/variants/explorer_screen_web.dart';
import '../../explorer_screen/variants/explorer_screen_web_2.dart';
import '../../profile_screen/profile_screen.dart';
import '../widgets/shopTile3.dart';
import 'list_screen_mobile_services.dart';


//https://www.etsy.com/?ref=lgo

final homePageProvider = StateProvider<int>((_) => 0);


class ListScreen_web extends ConsumerWidget {
  ListScreen_web({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
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
                Stack(
                    children:[
                      Container(height: 300, width:MediaQuery.of(context).size.width, child:Image.asset("hair-spies-TNhm6uVurpU-unsplash.jpg",fit: BoxFit.fitWidth,)),
                      Center(child: ServicesListDesktop())
                    ]
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Near You shops for you", style: TextStyle(fontSize: 40,fontFamily: "Roboto"),),
                ),
                TextButton(
                    onPressed: (){
                      pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings( name: '/services'),
                        screen: ListScreen_mobile_services(),
                      );
                    },
                    child: Text("sea all")
                ),
                HorizontalListWeb(),
              ],
            ),
          ),
        ),
        MapScreen(),
        ExplorerScreen_web2(),
        adminRegisterScreen()

      ];
    }

   return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(30,0,0,8),
          child: SvgPicture.asset("cdsgraphics-Barber-Shop-Pole.svg", color: Colors.white,),
        ),
        //leading: Icon(Icons.hail_rounded),
        toolbarHeight: 100,
        flexibleSpace: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width/2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      )
                  ),
                  authControllerState != null?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_)=>profileScreen(),

                          ),
                        );
                        /*                     pushNewScreenWithRouteSettings(

                        context,
                        settings: RouteSettings(name: '/profile'),
                        screen: profileScreen(),
                      );*/
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ):TextButton(
                      onPressed: () {
                        GoRouter.of(context).go("/login");
                      },
                      child: Text("Sign In!")
                  )

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
                        onPressed: (){ref.read(homePageProvider.notifier).state=2;},
                        child: Text("Fedezd fel!")
                    ),
                    TextButton(
                        onPressed: (){ref.read(homePageProvider.notifier).state=3;},
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
        ref.read(barberListForShopStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
        ref.read(barberListStateProvider.notifier).retrieveBarbersFromShop2(barbershop.id!);
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