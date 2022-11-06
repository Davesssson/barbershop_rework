import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../models/barber/barber_model.dart';

class editNameAndDescription extends ConsumerWidget {
  const editNameAndDescription({
    Key? key,
    required this.textNameController,
    required this.textDescriptionController,
    required this.barberUnderEdit,
  }) : super(key: key);

  final TextEditingController textNameController;
  final TextEditingController textDescriptionController;
  final Barber? barberUnderEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Név",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/3,
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    controller: textNameController
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width/3,
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    controller: textDescriptionController
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    barberUnderEdit != null
                        ? {
                      print("nem vagyok nulla, tudok updatelődni"),
                      ref.read(barberListForShopStateProvider(barberUnderEdit!.barbershop_id!).notifier)
                          .updateBarber(
                          updatedBarber: barberUnderEdit!.copyWith(
                              name: textNameController.text.trim(),
                              description: textDescriptionController
                                  .text
                                  .trim()
                          )
                      )
                    }
                        : {
                      print("nulla vagyok, nem tudok updatelődni"),
                      ref.read(barberListForShopStateProvider(barberUnderEdit!.barbershop_id!).notifier)
                          .addBarber(
                          name: textNameController.text.trim(),
                          description:textDescriptionController.text.trim(),
                          shopId: barberUnderEdit!.barbershop_id!
                      )
                    };
                  },
                  child: barberUnderEdit == null
                      ? Text("Hozz Létre és adj hozzá egy fodrászt",style: TextStyle(color:Colors.black))
                      : Text("Mentsd el a fodrász változtatásait",style: TextStyle(color:Colors.black))),
            ),
          ],
        ),
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/2.5,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: barberUnderEdit==null?Icon(Icons.no_accounts): barberUnderEdit!.prof_pic==null?Icon(Icons.no_accounts):Image.network(barberUnderEdit!.prof_pic!,fit: BoxFit.cover,)
            )
          ],
        )
      ],
    );
  }
}