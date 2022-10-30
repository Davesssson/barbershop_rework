import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_featured_provider.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/barbershop_controller/barbershop_controller.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import 'dart:developer' as developer;
import '../../../controllers/service_controller/service_providers.dart';
import '../../profile_screen/profile_screen.dart';
import '../widgets/shopTile3.dart';
import 'list_screen_mobile_pagination_mine.dart';
import 'list_screen_mobile_services.dart';

final currentShop_final = Provider<Barbershop>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ListScreen_mobile_final extends HookConsumerWidget {
  const ListScreen_mobile_final({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return Scaffold(
      body: ListView(
        children:[// Column( //TODO ha valami összefossa magát akkor a ListViewt cseréld ki Column-ra és állítsd be a
          //mainAxisSize: MainAxisSize.min,
         // children: [
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        greeting(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      )
                    ),
                  ),
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

                    },
                    child: Text("Sign In!")
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width-50,
                color: Theme.of(context).cardColor,
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Heloka',
                        textStyle: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 1000),
                      ),
                    ],
               ),
                ),
              ),
            ),
            TextButton(
                onPressed: (){
                  ref.watch(authControllerProvider.notifier).signInAnonymously();
                  MyLogger.singleton.logI("");
                },
                child: Text("login")
            ),//Discover
            TextButton(
                onPressed: (){
                  ref.watch(authControllerProvider.notifier).signOut();
                },
                child: Text("logout")
            ),//
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Featured Saloons",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )
              ),
            ),
            HorizontalList(
                stateProvider: barbershopListFeaturedStateProvider,
                contentProvider: barbershopListFeaturedContentProvider,
                shopToWatch: featuredShop
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Find Services",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: (){
                              pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings( name: '/services'),
                                screen: ListScreen_mobile_services(),
                              );
                            },
                          child: Text("sea all")
                        ),
                      )
                    ],
                  )
              ),
            ),
            ServicesList(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Near you",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  )
              ),
            ), //Near You

            HorizontalList(
                stateProvider: barbershopListStateProvider, //TODO Cseréld ki ténylegesen a Near You-ra
                contentProvider: barbershopListContentProvider,
                shopToWatch: nearYouShop
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Featured Barbers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )
            ),
          ),
          SizedBox(height: 300,)
          ],
        ),
    );
  }

  String greeting(){
    //5-9 reggelt
    //9-12 délelőtt
    //12-17 délutánt
    //17-20 estét
    //20-5 éjszakát
    final time = DateTime.now();
    if(time.hour>20 && time.hour<5)
      return "Szép éjszakát";
    else if(time.hour>5&&time.hour<9)
      return "Jó reggelt";
    else if(time.hour>9&&time.hour<12)
      return "Szép délelőttöt";
    else if(time.hour>12 && time. hour< 17)
      return "Szép délutánt";
    else if(time.hour >17 && time.hour < 20)
      return "Szép estét";
    else return ("Üdv");
  }
}

class ServicesList extends ConsumerWidget {
  const ServicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   final tags =  ref.watch(serviceTagsProvider);
    return tags.when(
        data: (tags){
          return SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...tags.map((e) =>
                    Container(
                      child:
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(radius: 45,backgroundColor: Colors.red,),
                          ),
                          Text(e.toString())
                        ],
                      ),

                    )
                  ).toList(),
              ],
            ),
          );
        },
        error: (e,_){return Text("service List error");},
        loading: (){return CircularProgressIndicator();}
    );
  }
}


class HorizontalList extends ConsumerWidget{
  const HorizontalList({
    Key? key,
    required this.stateProvider,
    required this.contentProvider,
    required this.shopToWatch,
  }) : super(key: key);

  final StateNotifierProvider<BarbershopListStateController, AsyncValue<List<Barbershop>>> stateProvider;
  final Provider<List<Barbershop>> contentProvider;
  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = ref.watch(this.stateProvider);
    final contentProvider = ref.watch(this.contentProvider);
    return stateProvider.when(
        data: (data){
          return data.isEmpty
              ? SizedBox(height: 100, child: Text("Sanjnos nincsen adat a horizontalList-ben"),)
              : SizedBox(
                  height: MediaQuery.of(context).size.height/3.2,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: contentProvider.length,
                    separatorBuilder: (context, index){
                      return const SizedBox(width: 20);
                    },
                    itemBuilder: (context, index) {
                      final barbershop = contentProvider[index];
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
final featuredShop = Provider<Barbershop>((_) {
  throw UnimplementedError();
});
final nearYouShop = Provider<Barbershop>((_) {
  throw UnimplementedError();
});
