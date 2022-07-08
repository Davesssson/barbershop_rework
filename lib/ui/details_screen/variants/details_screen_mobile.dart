
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
    final arg = ModalRoute.of(context)?.settings.arguments;
    final singleBarbershopState = ref.watch(BarbershopSingleControllerProvider(arg.toString()));

    return SingleChildScrollView(
      child: singleBarbershopState.when(
            data: (data)=>Column(
              children: [
                Text(data.name!),
                DetailWidget_mobile(ids:data.barbers!)
              ],
            ),
            error: (e,_)=>Text(e.toString()),
            loading: ()=>CircularProgressIndicator(),
      ),
    );


  }
}

class DetailWidget_mobile extends ConsumerWidget {
  final ids;
  const DetailWidget_mobile({Key? key,required this.ids}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barbersState=ref.watch(BarberListControllerFromShopProvider(ids));
    final filteredBarbers2=ref.watch(filteredBarberListFromShopProvider(ids));

    print("widget kapott ids = ");
    print(ids);
    return barbersState.when(
        data: (data)=>data.isEmpty
        ? const Center(
          child: Text("sajnos a barberek uresek"),
        )
        :ListView.builder(
          shrinkWrap: true,
          itemCount: filteredBarbers2.length,
          itemBuilder:(BuildContext context, int index){
            final barber = filteredBarbers2[index];
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

class DetailWidget_mobile2 extends ConsumerWidget{
  final barbershop;
  DetailWidget_mobile2({Key? key, required this.barbershop}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final barberListState = ref.watch(BarberListControllerProvider);
    final filteredBarberList = ref.watch(filteredBarberListProvider);

    return
       barberListState.when(
           data: (items) => items.isEmpty
               ?Text("asd")
               :Text(items.length.toString()),


          error: (e,_)=> Text("asd"),
          loading: ()=>Text("loading")

    );
  }
}

