import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_barbers_screen/widgets/addNewBarberTile.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_barbers_screen/widgets/barberGrid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/barber_controller/barber_providers.dart';

class admin_barbers extends ConsumerWidget {
  final String shopId;
  admin_barbers({
    Key? key,
    required this.shopId
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberState = ref.watch(barberListForShopStateProvider(shopId));
    return barberState.when(
        data: (barbers) {
      return barbers.isEmpty
          ? Container(
              child: GridView.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: (MediaQuery.of(context).size.width / 350).toInt(),
                children: [
                  Text("Hát tesóm, neked nincsenek barbereid, veszel fel?"),
                  addNewBarberTile(),
                ],
              ),
            )
          : barberGrid(shopId: shopId,);
    }, error: (e, _) {
      return Text(e.toString());
    }, loading: () {
      return CircularProgressIndicator();
    });
  }
}
