
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../../controllers/auth_controller.dart';
import '../../../../../models/barbershop/barbershop_model.dart';
import '../../../../book_screen/choose_barber.dart';

class BookNowButton extends ConsumerWidget {
  final Barbershop bs;
  const BookNowButton({Key? key, required this.bs}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return
      authControllerState!=null
          ? TextButton(
          onPressed: () {
            pushNewScreenWithRouteSettings(
              context,
              settings: RouteSettings(name: '/book', arguments: bs),
              screen: chooseBarber(),
            );
          },
          child: Text("kattints ram")
      ):TextButton(
          onPressed: (){
            final snackBar = SnackBar(
              content: const Text('JELENTKEZZ BE KÖCSÖG'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Text("nem vagy bejelentkezve")
      );
  }
}