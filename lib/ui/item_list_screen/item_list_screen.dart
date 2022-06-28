import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/item_list_screen/variants/item_list_screen_mobile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/item_list_controller.dart';
import '../../models/item_model.dart';

class ItemListScreen extends ConsumerWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final isObtainedFilter =
        ref.watch(itemListFilterProvider.notifier).state == ItemListFilter.all;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        leading: authControllerState != null
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                  //Navigator.pushNamed(context, '/login');
                  Navigator.of(context, rootNavigator: true)
                      .popAndPushNamed('/login');
                  //Navigator.pushNamed(context, '/login');
                })
            : IconButton(
                icon: const Icon(Icons.abc),
                onPressed:
                    () {} //=> ref.read(authControllerProvider.notifier).signInAnonymously(),
                ),
        actions: [
          IconButton(
            icon: Icon(
              isObtainedFilter
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            onPressed: () {
              //TODO NEM SZÉP, DE CSÚNYA, ERRE KI KELL TALÁLNI VALAMIT
              if (ref.watch(itemListFilterProvider.notifier).state ==
                  ItemListFilter.all) {
                ref.watch(itemListFilterProvider.notifier).state =
                    ItemListFilter.obtained;
              } else
                ref.watch(itemListFilterProvider.notifier).state =
                    ItemListFilter.all;
              print("megnyomodtam genyo");
              print(ref.watch(itemListFilterProvider.state).state);
            },
          ),
        ],
      ),
      body: ScreenTypeLayout(
        mobile: ItemListScreen_mobile(),
        desktop: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Container(color: Colors.pink)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
