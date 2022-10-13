import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/barber_controller/barber_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/barber/barber_model.dart';

class editView extends HookConsumerWidget {
  final Barber? barberUnderEdit;
  const editView({Key? key, this.barberUnderEdit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textNameController = useTextEditingController(
      text: barberUnderEdit?.name ?? 'valami'
    );
    final textDescriptionController = useTextEditingController(text: barberUnderEdit?.description ?? 'valami');
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.green,),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width/8
          ),
          color: Colors.red,
          child: Column(
            children: [
              Text("Name"),
              TextFormField(
                  controller: textNameController,
              ),
              Text("Description"),
              TextFormField(
                controller: textDescriptionController,
                maxLines: 3,
              ),
              TextButton(
                  onPressed: (){ // más providernél nem fog updatelődni amig ujra le nem kérik
                    barberUnderEdit!=null
                        ? {
                          print("nem vagyok nulla, tudok updatelődni"),
                          ref.read(barberListForShopStateProvider.notifier)
                              .updateBarber(
                              updatedBarber: barberUnderEdit!.copyWith(
                                  name: textNameController.text.trim(),
                                  description: textDescriptionController.text.trim()
                              )
                          )
                        }
                        : {
                          print("nulla vagyok, nem tudok updatelődni"),
                          ref.read(barberListForShopStateProvider.notifier)
                              .addBarber(
                                name: textNameController.text.trim(),
                                description: textDescriptionController.text.trim(),
                                shopId: '7HTJ8DF8hFwUnrL566Wc')
                         };
                  },
                  child: Text("save changes")
              )


            ],
          ),
        )
    );
  }
}
