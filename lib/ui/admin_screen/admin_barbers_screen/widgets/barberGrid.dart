import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../controllers/barber_controller/barber_providers.dart';
import 'addNewBarberTile.dart';
import 'barberTile.dart';

class barberGrid extends ConsumerWidget {
  final String shopId;
  const barberGrid({
    required this.shopId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberContent = ref.watch(barberListForShopStateProvider(shopId));
    return barberContent.when(
        data: (barbers){
          return barbers.isEmpty
              ?Text("hát..itt nincsenek barberek")
              :GridView.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: (MediaQuery.of(context).size.width / 350).toInt(),
            children: [
              ...barbers.map((existingBarber) {
                return BarberTile(existingBarber: existingBarber);
              }).toList(),
              addNewBarberTile(),
            ],
          );
        },
        error: (e,_){return Text("nem tudjuk a barbereket behuzni, sorry");},
        loading: (){return CircularProgressIndicator();}
    );
  }
}