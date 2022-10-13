import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/ui/admin_screen/edit_barber_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controllers/barber_controller/barber_providers.dart';
import '../../models/barber/barber_model.dart';

class admin_barbers extends ConsumerWidget {
  admin_barbers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberState = ref.watch(barberListForShopStateProvider);
    final barberContent = ref.watch(barberListForShopContentProvider);
    return barberState.when(data: (barbers) {
      return barbers.isEmpty
          ? Container(
              child: Text("Hat tesom, neked nincsenek barbereid. Veszel fel?"),
              color: Colors.red,
            )
          : GridView.count(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: (MediaQuery.of(context).size.width / 350).toInt(),
              children: [
                ...barberContent.map((existingBarber) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return editView( barberUnderEdit: existingBarber, );
                          }
                      ));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.black,
                      child: Text(existingBarber.name!),
                    ),
                  );
                }).toList(),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return editView( barberUnderEdit: null,);
                        }
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.black,
                    child: Text("add new"),
                  ),
                ),
              ],
            );
      //region GridView
      /* : Container(
                child: GridView.builder(
                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                     maxCrossAxisExtent: 400,
                     childAspectRatio: 3 / 2,
                     crossAxisSpacing: 20,
                     mainAxisSpacing: 20
                 ),
                 itemCount: barberContent.length,
                 itemBuilder: (BuildContext context, index) {
                   final barber = barberContent[index];
                   return InkWell(
                     onTap: (){},
                     child: Container(
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                barber.prof_pic!
                              )
                            ),
                           color: Colors.amber,
                           borderRadius: BorderRadius.circular(15)),
                       child: Text(barber.name!),
                     ),
                   );
                 }
                ),
              );*/
      //endregion GridView
      //region Table
      /*ListView(
                children:[
                  DataTable(
                  border: TableBorder.all(),
                  columns: [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("valami")),
                    DataColumn(label: Text("valami2")),
                  ],
                  rows: [
                    ...barbers.map((e) {
                      return DataRow(
                          onSelectChanged: (_){

                          },
                          cells: [
                            DataCell(
                                Text(e.name!),
                              onTap:
                            ),
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
              );*/
      //endregion Table
    }, error: (e, _) {
      return Text(e.toString());
    }, loading: () {
      return CircularProgressIndicator();
    });
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
                style: ElevatedButton.styleFrom(),
                onPressed: () {},
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
