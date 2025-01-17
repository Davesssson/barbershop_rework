import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../models/barber/barber_model.dart';
import '../../../models/barbershop/barbershop_model.dart';
import '../choose_time/choose_time.dart';
import 'widgets/bookBarberGridView.dart';

class chooseBarber extends ConsumerWidget {
  const chooseBarber({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Barbershop barbershop =
    ModalRoute.of(context)?.settings.arguments as Barbershop;
    final barbersState =  ref.watch(retrieveBarbersWorks(barbershop.id!));
    return Scaffold(
      body: barbersState.when(
          data: (barbers) {
            return barbers.isEmpty
                ? Container(
                    child: Text("Hat tesom, neked nincsenek barbereid. Veszel fel?"),
                    color: Colors.red,
                  )
                : SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: MediaQuery.of(context).size.height/3, child: Image.network(barbershop.main_image!,fit: BoxFit.fitWidth,)),
                          Column(
                            children: [
                              Text(barbershop.name!, style: TextStyle(fontSize: 30),),
                              Text(barbershop.city!, style: TextStyle(fontSize: 30),),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(child: Text("Choose your fighter!",style: TextStyle(fontSize: 30))),
                      ),
                      bookBarberGridView(barbers: barbers, barbershop: barbershop,),
                      Container(color:Colors.red,height: 500,) //TODO works
                    ],
                  ),
                );

          },
          error: (e, _) => Text(e.toString()),
          loading: () => const CircularProgressIndicator())
    );
  }
}



