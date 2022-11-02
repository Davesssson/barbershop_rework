import 'package:flutter/material.dart';

import '../../../../models/barbershop/barbershop_model.dart';
import '../mobile/widgets/about.dart';
import '../mobile/widgets/reviews_tab.dart';
import '../mobile/widgets/serviceList.dart';
import '../mobile/widgets/works_tab.dart';

class DetailsScreen_web extends StatelessWidget {
  final Barbershop barbershop;
  const DetailsScreen_web({Key? key,required this.barbershop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.hail_rounded),
        toolbarHeight: 100,
        flexibleSpace: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          //ref.read(homePageProvider.notifier).state=0;
                        },
                        child: Text("Böngéssz üzletek között!")
                    ),
                    TextButton(
                        onPressed: (){/*ref.read(homePageProvider.notifier).state=1;*/},
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
      )
    );
  }
}
