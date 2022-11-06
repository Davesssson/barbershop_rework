import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../models/barber/barber_model.dart';
import 'confirmationDialog.dart';

class barberWorksGridView extends ConsumerWidget {
  final Barber? barberUnderEdit;
  const barberWorksGridView({
    Key? key,
    required this.barberUnderEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      crossAxisCount: (MediaQuery.of(context).size.width / 350).toInt(),
      children: [
        if(barberUnderEdit!=null)
          ...barberUnderEdit!.works!.map((picture) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => confirmationDialog(barberUnderEdit:barberUnderEdit, context: context, picture: picture,),
                ),
                child: Image.network(picture),
              ),
            );
          }).toList(),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: DottedBorder(
            color: Colors.white,
            strokeWidth: 2,
            dashPattern: [5, 5],
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text("Tölts fel új képet"),
                    Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}