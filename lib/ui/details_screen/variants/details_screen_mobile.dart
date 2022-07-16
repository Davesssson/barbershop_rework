
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
      body: SingleChildScrollView(
        child: singleBarbershopState.when(
              data: (data)=>
              DetailWidget_mobile(ids: data.barbers),
              //  Column(
              //   children: [
              //     Text(data.name!),
              //     DetailWidget_mobile(ids:data.barbers!)
              //   ],
              // ),
              error: (e,_)=>Text(e.toString()),
              loading: ()=>CircularProgressIndicator(),
        ),
      ),
    );


  }
}

class DetailWidget_mobile extends ConsumerWidget {
  final ids;
  const DetailWidget_mobile({Key? key,required this.ids}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barbersState=ref.watch(barberListFromShopStateProvider(ids));
    final barbersContent=ref.watch(barberListFromShopContentProvider(ids));


    return barbersState.when(
        data: (data)=>data.isEmpty
        ? const Center(
          child: Text("sajnos a barberek uresek"),
        )
        :ListView.builder(
          shrinkWrap: true,
          itemCount: barbersContent.length,
          itemBuilder:(BuildContext context, int index){
            final barber = barbersContent[index];
            return Text(barber.name!);
          }
        ),
        error: (e,_)=>Text(e.toString()),
        loading: ()=>CircularProgressIndicator(),
    );


  }
}

final currentBarber = Provider<Barber>((_) {
  developer.log("[item_list_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});


