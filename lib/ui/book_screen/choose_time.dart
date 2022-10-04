
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controllers/barber_controller/barber_providers.dart';

class chooseTime extends ConsumerWidget {
  const chooseTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.read(availabilityProvider);
    final barbersState = ref.watch(barberListForShopStateProvider);
    final barbersContent = ref.watch(barberListForShopContentProvider);
    return Scaffold(
      body:ListView.builder(
          itemCount: details.value!.length,
          itemBuilder: (context,index){
            return ListTile(title:Text("asd"));
          }
      )
/*      body: details.asData!.when(
          data: (data){
            return Text("asd");
          },
          error: (e,_){return Text("error");},
          loading: (){return CircularProgressIndicator();}
      )*/

    );
  }
}
