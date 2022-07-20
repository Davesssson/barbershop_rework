
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/barber_controller.dart';
import 'dart:developer' as developer;

import '../../../controllers/barber_controller.dart';
import '../../../models/barber/barber_model.dart';



class DetailsScreen_mobile extends HookConsumerWidget {
  const DetailsScreen_mobile({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = ModalRoute.of(context)?.settings.arguments as String;
    final singleBarbershopState = ref.watch(barbershopSingleStateProvider(arg));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: singleBarbershopState.when(
              data: (data)=>
              SingleChildScrollView(
                  child: DetailWidget_mobile(bs: data)
              ),
              //  Column(
              //   children: [
              //     Text(data.name!),
              //     DetailWidget_mobile(ids:data.barbers!)
              //   ],
              // ),
              error: (e,_)=>Text("barbershopot nem tudtuk betölteni"),
              loading: ()=>CircularProgressIndicator(),
        ),

    );


  }
}

class DetailWidget_mobile extends ConsumerWidget {
  final Barbershop bs;
  const DetailWidget_mobile({Key? key,required this.bs}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbersState=ref.watch(barberListFromShopStateProvider(bs.barbers!));
    final barbersContent=ref.watch(barberListFromShopContentProvider(bs.barbers!));

    //TODO EZT KELL ÁTÍRNI ÚGY, HOGY A WIDGET BUILDELJEN, CSAK AZ ADOTT KONTÉNER MUTASSON MÁST
    return barbersState.when(
        data: (data)=>data.isEmpty
        ? const Center(
          child: Text("sajnos a barbereket nem sikerült betölteni, vagy üresek"),
        )
        :Column(
          children:[
            Header(bs: bs),
            Container(height: 50,color: Colors.red,child: Text("Ide jon még az elérhetőség"),),
            BarberList(barbersContent: barbersContent),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,8,0,8),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child:Text("Munkatársak",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 16
                    ),
                  )
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    Container(height: 40,width: 100,color: Colors.blue,),
                    Container(height: 40,width: 100,color: Colors.red,),
                    Container(height: 40,width: 100,color: Colors.green,),
                    Container(height: 40,width: 100,color: Colors.blue,),
                    Container(height: 40,width: 100,color: Colors.grey,),
                    Container(height: 40,width: 100,color: Colors.green,),
                  ],
                )
            ),


            Container(height: 300,color: Colors.red,),
            Container(height: 300,color: Colors.blue,),
            Container(height: 300,color: Colors.green,),



         ]
        ),
        error: (e,_)=>Text(e.toString()),
        loading: ()=>CircularProgressIndicator(),
    );


  }
}

class BarberList extends StatelessWidget {
  const BarberList({
    Key? key,
    required this.barbersContent,
  }) : super(key: key);

  final List<Barber> barbersContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 151,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: barbersContent.length,
          itemBuilder:(BuildContext context, int index){
            final barber = barbersContent[index];
            //return Text(barber.name!);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (_)=>StoryViewer(barber: barber)
                    //   ),);
                  },
                  child: Container(
                    color:Colors.black54,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(barber.prof_pic!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(barber.name!,style: TextStyle(color: Colors.white70),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.bs,
  }) : super(key: key);

  final Barbershop bs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(bs.main_image!))),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent
                  ]
              )
          ),
        ),
        Positioned(
            left: 10,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bs.name!,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white70
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}

final currentBarber = Provider<Barber>((_) {
  developer.log("[item_list_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});


