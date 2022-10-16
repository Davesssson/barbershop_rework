
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import 'choose_time.dart';

class chooseBarber extends ConsumerWidget {
  const chooseBarber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbersState = ref.watch(barberListForShopStateProvider);
    final barbersContent = ref.watch(barberListForShopContentProvider);
    return Scaffold(
/*      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(title:Text(index.toString()),);
          }
      )*/
      //region asd
      body: barbersState.when(
          data: (data) => data.isEmpty
            ? Text("ures vagyok")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: barbersContent.length,
                itemBuilder: (BuildContext context, int index) {
                final barber = barbersContent[index];
                  return ListTile(
                    title: Text(barber.name!),
                    onTap: () {
                      pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: '/book'),
                        screen: chooseTime(barberId:barber.id!),
                      );
                    },
                  );
                }),
          error: (e, _) => Text(e.toString()),
          loading: () => const CircularProgressIndicator())
    //endregion asd
    );
  }
}
