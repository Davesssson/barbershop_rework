import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/book_screen/choose_barber.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/about.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/barberList.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/header.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/serviceList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'dart:developer' as developer;
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/place_controller.dart';
import '../../../../models/barber/barber_model.dart';
import '../../../../models/service/service_model.dart';

class DetailsScreen_mobile extends HookConsumerWidget {
  const DetailsScreen_mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Barbershop barbershop =
        ModalRoute.of(context)?.settings.arguments as Barbershop;
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: DetailWidget_mobile(bs: barbershop));
  }
}

class DetailWidget_mobile extends ConsumerWidget {
  final Barbershop bs;
  DetailWidget_mobile({Key? key, required this.bs}) : super(key: key);
  final items = List<String>.generate(10000, (i) => 'Item $i');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

    return DefaultTabController(
        length: 4,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                  child:Column(
                      children: [
                        Header(bs: bs),
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: Text("Ide jon még az elérhetőség"),
                        ),
                        buildCoworkers(),
                        BarberList(),
                        //buildServices(),
                        //ServiceList(),
                        authControllerState!=null
                            ?
                        TextButton(
                            onPressed: () {
                              pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(name: '/book', arguments: bs),
                                screen: chooseBarber(),
                              );
                            },
                            child: Text("kattints ram")
                        ):TextButton(
                            onPressed: (){
                              final snackBar = SnackBar(
                                content: const Text('JELENTKEZZ BE KÖCSÖG'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            },
                            child: Text("nem vagy bejelentkezve")
                        )
                        ,
                        TabBar(
                          tabs: [
                            Tab(child:Text('General')),
                            Tab(child:Text('Szolgáltatások')),
                            Tab(child:Text('Termékek')),
                            Tab(child:Text('Reviews')),
                          ],
                        )
                      ]
                  )
              )
            ],
          body: TabBarView(
            children: [
              buildAbout(),
              ServiceList(),
              //Container(color: Colors.blue,height: 200,),
              buildReviews(),
              //Container(color: Colors.red,height: 200,),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: 4,
                  itemBuilder: (context,index){
                    return Container(
                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(items[index].toString()),
                    );
                  })
            ],
          ),
        ),
    );

    return ListView(children: [
      Header(bs: bs),
      Container(
        height: 50,
        color: Colors.red,
        child: Text("Ide jon még az elérhetőség"),
      ),
      buildCoworkers(),
      BarberList(),
      buildServices(),
      ServiceList(),
      TextButton(
          onPressed: () {
            pushNewScreenWithRouteSettings(
              context,
              settings: RouteSettings(name: '/book'),
              screen: chooseBarber(),
            );
          },
          child: Text("kattints ram")
      ),
    ]);
  }

  Padding buildServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Szolgáltatások",
            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                fontWeight: FontWeight.bold,
                color: Colors.white60,
                fontSize: 30),
          )),
    );
  }

  Padding buildCoworkers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Munkatársak",
            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                fontWeight: FontWeight.bold,
                color: Colors.white60,
                fontSize: 30),
          )),
    );
  }
}

class buildReviews extends ConsumerWidget {
  const buildReviews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final detailsResponse = ref.watch(detailsResultProvider('ChIJP6SRA2bcQUcRd4Q6z-4PUTI'));

    return detailsResponse.when(
        data: (DetailsResponse d){
          return ListView.builder(
            itemCount: d.result!.reviews!.length,
            itemBuilder: (context,index){
              final currentReview = d.result!.reviews![index];
              return ListTile(
                //leading: Image.network(currentReview.profilePhotoUrl!),
                title: Padding(
                  padding: const EdgeInsets.only(top:3,bottom: 3),
                  child: Text(currentReview.authorName!),
                ),
                subtitle: Text(currentReview.text!),
              );

            },
          );
        } ,
        error: (e,_){return Text("fos");},
        loading: (){return CircularProgressIndicator();}
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
