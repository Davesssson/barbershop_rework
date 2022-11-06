
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../controllers/explorer_controller/explorer_providers.dart';
import '../../../models/barber/barber_model.dart';
import 'explorer_screen_mobile.dart';

final currentBarber = Provider<Barber>((_) {
  throw UnimplementedError();
});

class ExplorerScreen_web extends ConsumerWidget {
   ExplorerScreen_web({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final barbers = ref.watch(BarberPaginationNotifierProvider);
    final length = ref.watch(BarberPaginationNotifierProvider.notifier).items.length;
    return Scaffold(
      //region appbar
      /*appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(30,0,0,8),
          child: SvgPicture.asset("cdsgraphics-Barber-Shop-Pole.svg", color: Colors.white,),
        ),
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
                        onPressed: (){*//*ref.read(homePageProvider.notifier).state=1;*//*},
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
      ),*/
      //endregion appbar
      body: barbers.when(
          data: (data){
            print("length="+length.toString());
            return PageView.builder(
                    pageSnapping: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      final barber = data[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ref.read(shopProvider(barber.barbershop_id!)).when(
                              data: (barbershop){
                                return Container(
                                  color:Theme.of(context).cardColor,
                                  child: Row(
                                    children: [
                                      Container(width:MediaQuery.of(context).size.width/2 , child: Image.network(barbershop.main_image!)),
                                      Column(
                                        children: [
                                          Text(barbershop.name!),
                                          Text(barbershop.city!),
                                          Text(barber.name!)

                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              error: (e,_){return Text(e.toString());},
                              loading: (){return CircularProgressIndicator();}
                          ),
                          Container(child: Image.network(barber.prof_pic!,fit:BoxFit.fitWidth),width: MediaQuery.of(context).size.width/2,)
                        ],
                      );
                    }
                );
          },
          loading: (){return CircularProgressIndicator();},
          error: (e,_st){return Text(e.toString());},
          onGoingLoading: (items) =>
          const Center(child: CircularProgressIndicator()),
          onGoingError: (items, e, stk) => Center(
            child: Column(
              children: const [
                Icon(Icons.info),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Something Went Wrong!",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
      )
    );
  }
}
