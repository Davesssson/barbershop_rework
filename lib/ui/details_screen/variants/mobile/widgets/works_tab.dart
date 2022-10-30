import 'dart:math';

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
        data: (barbers){
          if(barbers.isEmpty) return Center(child: Text("Nincsenek megjeleníthető képek"),);
          List<Widget> images =[];
          barbers.forEach((barber) {
            if(barber.works!=null){
              barber.works!.forEach((work) {
                images.add(
                  Image.network(work)
                );
              });
            }
          });
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: images.length,
              itemBuilder: (context,index){
                return images[index];
              }
          );



/*          return data.isNotEmpty?
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
           :Text("Bocs haver, ez most nem fog összejönni");*/
        },
        error: (e,_st){return Text(e.toString());},
        loading: (){return CircularProgressIndicator();}
    );
  }
}

class woorkGrid extends ConsumerWidget {
  final Barber b;
  const woorkGrid({
    required this.b,
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      crossAxisCount: (MediaQuery.of(context).size.width / 350).toInt(),
      children: [
        ...b.works!.map((picture) {
          return Image.network(picture);
        }).toList(),
      ],
    );
  }
}