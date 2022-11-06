
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../models/barber/barber_model.dart';
import '../../choose_time/choose_time.dart';


class bookBarberTile extends StatelessWidget {
  final Barber existingBarber;
  final barbershop;
   bookBarberTile({
    required this.existingBarber,
    required this.barbershop,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: '/book'),
          screen: chooseTime(barberId:existingBarber.id!, barbershop: barbershop,),
        );
      },
      child: Container(
        height: 50,
        width: 50,
        color: Colors.black,
        child: Stack(
          children: [
            existingBarber.prof_pic!=null? Image.network(existingBarber.prof_pic!,fit: BoxFit.fill):SizedBox(),
            Text(existingBarber.name!)
          ],
        ),
      ),
    );
  }
}