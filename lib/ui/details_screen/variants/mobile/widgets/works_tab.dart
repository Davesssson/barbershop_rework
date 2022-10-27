import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../../models/barber/barber_model.dart';
class Works extends ConsumerWidget {
  final barbershopId;
  const Works({
    required this.barbershopId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final works =  ref.watch(retrieveBarbersWorks(barbershopId));

    return works.when(
        data: (data){
          return data.isNotEmpty?
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (context,index){
                Barber b = data[index];
                return Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(b.name!),
                );
              }
          )
              :Text("Bocs haver, ez most nem fog összejönni");
        },
        error: (e,_st){return Text(e.toString());},
        loading: (){return CircularProgressIndicator();}
    );
  }
}