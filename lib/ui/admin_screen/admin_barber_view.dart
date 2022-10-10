import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/barber_controller/barber_providers.dart';


class admin_barbers extends ConsumerWidget {
  const admin_barbers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberState = ref.watch(barberListForShopStateProvider);
    final barberContent = ref.watch(barberListForShopContentProvider);
    return barberState.when(
        data: (barbers){
           return barbers.isEmpty
              ? Container(child: Text("Hat tesom, neked nincsenek barbereid. Veszel fel?"),color: Colors.red,)
              :ListView(
                children:[
                  DataTable(
                  sortAscending: true,
                  border: TableBorder.all(),
                  columns: [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("valami")),
                    DataColumn(label: Text("valami2")),
                  ],
                  rows: [
                    ...barbers.map((e) {
                      return DataRow(
                          cells: [
                            DataCell(Text(e.name!)),
                            DataCell(Text("asd")),
                            DataCell(Text("asd")),
                          ]
                      );
                    }).toList()
                  ],
                  ),
                  TextButton(
                      onPressed: (){
                        return AddItemDialog.show(context);
                      },
                      child: Text("adj hozza uj embit")
                  )

                ]
              );
        },
        error: (e,_){return Text(e.toString());},
        loading: (){return CircularProgressIndicator();}
    );
  }
}

class AddItemDialog extends HookConsumerWidget {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(),
    );
  }
  const AddItemDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: "asd");
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                ),
                onPressed: () {
                },
                child: Text( 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

