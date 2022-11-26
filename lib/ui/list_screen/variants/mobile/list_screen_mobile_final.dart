import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_featured_provider.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../../controllers/auth_controller.dart';
import 'dart:developer' as developer;
import '../../widgets/servicesList_mobile.dart';
import '../list_screen_mobile_services.dart';
import 'widgets/animatedText.dart';
import 'widgets/horizontalList.dart';
import 'widgets/horizontalList2.dart';
import 'widgets/upperRow.dart';

final currentShop_final = Provider<Barbershop>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ListScreen_mobile_final extends HookConsumerWidget {
  const ListScreen_mobile_final({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children:[// Column( //TODO ha valami összefossa magát akkor a ListViewt cseréld ki Column-ra és állítsd be a
          //mainAxisSize: MainAxisSize.min,
         // children: [
            SizedBox(height: 25),
            UpperRow(),

            animatedText(),
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
            ServicesListMobile(),
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

            HorizontalList2(
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
}

final featuredShop = Provider<Barbershop>((_) {
  throw UnimplementedError();
});
final nearYouShop = Provider<Barbershop>((_) {
  throw UnimplementedError();
});
