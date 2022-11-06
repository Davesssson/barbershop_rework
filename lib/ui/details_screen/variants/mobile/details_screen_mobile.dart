import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/book_screen/choose_barber/choose_barber.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/about.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/barberList.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/book_now_button.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/header.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/reviews_tab.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/serviceList.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/works_tab.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'dart:developer' as developer;
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../controllers/place_controller.dart';
import '../../../../controllers/theme_controller.dart';
import '../../../../models/barber/barber_model.dart';
import '../../../../models/service/service_model.dart';

class DetailsScreen_mobile extends HookConsumerWidget {
  final Barbershop barbershop;
  const DetailsScreen_mobile({Key? key, required this.barbershop}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final Barbershop barbershop =
        //ModalRoute.of(context)?.settings.arguments as Barbershop;
    return Scaffold(
      //backgroundColor: Colors.black,
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, ),
            //onPressed: () => Navigator.of(context).pop(),
            onPressed: () => GoRouter.of(context).go("/")
          ),
        ),
        body: DetailWidget_mobile(bs: barbershop));
  }
}

class DetailWidget_mobile extends ConsumerWidget {
  final Barbershop bs;
  DetailWidget_mobile({Key? key, required this.bs}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 4,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
              SliverToBoxAdapter(
                  child:Column(
                      children: [
                        Header(bs: bs),
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: Text("Ide jon még az elérhetőség"),
                        ),
                        buildCoworkersText(),
                        BarberList(),
                        BookNowButton(bs:bs),
                        TabBar(
                          tabs: [
                            Tab(child:Text('General')),
                            Tab(child:Text('Szolgáltatások')),
                            Tab(child:Text('Reviews')),
                            Tab(child:Text('Munkáink')),
                          ],
                        )
                      ]
                  )
              )
            ];
          },
          body: TabBarView(
            children: [
              About(placesId:bs.places_id),
              Services(barbershopId:bs.id),
              Reviews(placesId:bs.places_id),
              Works(barbershopId: bs.id)
            ],
          ),
        ),
    );
  }


  Padding buildCoworkersText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Munkatársak",
            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
          )
      ),
    );
  }
}

final currentBarber = Provider<Barber>((_) {
  developer.log("[item_list_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

final currentService = Provider<Service>((_) {
  developer.log("[.dart][currentItem] - ??????.");
  throw UnimplementedError();
});
