import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/widgets/web_appBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../models/barbershop/barbershop_model.dart';
import '../../../book_screen/choose_barber/choose_barber.dart';
import '../mobile/widgets/about.dart';
import '../mobile/widgets/barberList.dart';
import '../mobile/widgets/reviews_tab.dart';
import '../mobile/widgets/serviceList.dart';
import '../mobile/widgets/works_tab.dart';

class DetailsScreen_web extends StatelessWidget {
  final Barbershop barbershop;
  const DetailsScreen_web({Key? key,required this.barbershop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: webAppBar(),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScroleld){
            return [
              SliverToBoxAdapter(
                  child:Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: Image.network(barbershop.main_image!,fit: BoxFit.cover,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BarberList(bs:barbershop),
                      ),
                      TabBar(
                        tabs: [
                          Tab(child:Text('General')),
                          Tab(child:Text('Szolgáltatások')),
                          Tab(child:Text('Reviews')),
                          Tab(child:Text('Munkáink')),
                        ],
                      )
                    ],
                  ),

              )
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),child: About(placesId: barbershop.places_id,)),
              Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5), child: Services(barbershopId: barbershop.id,)),
              Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5), child: Reviews(placesId: barbershop.places_id,)),
              Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5), child: Works(barbershopId:barbershop.id)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //extendedPadding:EdgeInsets.fromLTRB(0, 0, 0,50),
        label: Text("FOGLALJ IDŐPONTOT MOST", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        onPressed: (){
          pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(name: '/book', arguments: barbershop),
            screen: chooseBarber(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
