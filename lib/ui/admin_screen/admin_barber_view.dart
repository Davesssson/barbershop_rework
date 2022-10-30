import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/ui/admin_screen/edit_barber_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controllers/barber_controller/barber_providers.dart';
import '../../models/barber/barber_model.dart';

class admin_barbers extends ConsumerWidget {
  final String shopId;
  admin_barbers({
    Key? key,
    required this.shopId
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberState = ref.watch(barberListForAdminStateProvider(shopId));
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

class barberGrid extends ConsumerWidget {
  final String shopId;
  const barberGrid({
    required this.shopId,
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barberContent = ref.watch(barberListForAdminStateProvider(shopId));
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

class BarberTile extends StatelessWidget {
  const BarberTile({
    required this.existingBarber,
    Key? key,
  }) : super(key: key);
  final Barber existingBarber;
  @override
  Widget build(BuildContext context) {
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
  }
}

class addNewBarberTile extends StatelessWidget {
  const addNewBarberTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return editView( barberUnderEdit: null,);
            }
        ));
      },
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
                Text("add new"),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
      ),
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
