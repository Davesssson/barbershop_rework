
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../models/barber/barber_model.dart';

class confirmationDialog extends ConsumerWidget {
  static void show(Barber barberUnderEdit, BuildContext context, String picture,){
    showDialog(
        context: context,
        builder: (context) => confirmationDialog(barberUnderEdit: barberUnderEdit, context: context, picture: picture)
    );
  }

  const confirmationDialog({
    Key? key,
    required this.barberUnderEdit,
    required this.context,
    required this.picture,
  }) : super(key: key);

  final Barber? barberUnderEdit;
  final BuildContext context;
  final String picture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Biztosan meg szeretnéd változtatni a barber profil képét?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ref.read(barberListForShopStateProvider(barberUnderEdit!.barbershop_id!).notifier) // TODO KICSERÉLNI SIMA ASYNC-ra
                .updateBarberProfPic(barberId: barberUnderEdit!.id!, profPictureLink: picture);
            Navigator.pop(context, 'Yes');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}