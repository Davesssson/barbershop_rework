import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/ui/map_screen/map_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/item_list_controller.dart';
import '../../../controllers/marker_controller/marker_providers.dart';
import '../../../controllers/theme_controller.dart';
import '../../../models/item/item_model.dart';
import '../../../repositories/custom_exception.dart';
import 'dart:developer' as developer;

final currentItem = Provider<Item>((_) {
  developer.log("[item_list_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ItemListScreen_mobile extends HookConsumerWidget {
  const ItemListScreen_mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListStateProvider);
    final filteredItemList = ref.watch(itemListContentProvider);
    final authControllerState = ref.watch(authControllerProvider);
    final isObtainedFilter = ref.watch(itemListFilterProvider.notifier).state == ItemListFilter.all;
    final radius = ref.watch(radiusProvider);
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
                      .popUntil(ModalRoute.withName('/login'));
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
          IconButton(
              onPressed: () {
                if (ref.watch(ThemeModeFilterProvider.notifier).state ==
                    ThemeModeFilter.dark) {
                  ref.watch(ThemeModeFilterProvider.notifier).state =
                      ThemeModeFilter.light;
                  print("switched from dark to light");
                } else if (ref.watch(ThemeModeFilterProvider.notifier).state ==
                    ThemeModeFilter.light) {
                  ref.watch(ThemeModeFilterProvider.notifier).state =
                      ThemeModeFilter.dark;
                  print("switched from light to dark");
                }
              },
              icon: Icon(Icons.map))
        ],
      ),
      body: itemListState.when(
        data: (items) => items.isEmpty
            ?  Center(
                child: Slider(
                  value: radius,
                  max: 1000,
                  divisions: 5,
                  label: radius.round().toString(),
                  onChanged: (double value) {
                    print("na ez lesz a jó"+ref.read(markerListStateProvider.notifier).getRadius().toString());
                    ref.read(markerListStateProvider.notifier).setRadius(value);
                    ref.read(radiusProvider.notifier).state=value;
                  },
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: filteredItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredItemList[index];
                  return ProviderScope(
                    overrides: [currentItem.overrideWithValue(item)],
                    child: const ItemTile(),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ItemListError(
          message: error is CustomException
              ? error.message!
              : 'Something went wrong!',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTile extends HookConsumerWidget {
  const ItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentItem);
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.name),
      trailing: Checkbox(
        value: item.obtained,
        onChanged: (val) => ref
            .read(itemListStateProvider.notifier)
            .updateItem(updatedItem: item.copyWith(obtained: !item.obtained)),
      ),
      onTap: () => AddItemDialog.show(context, item),
      onLongPress: () => ref
          .read(itemListStateProvider.notifier)
          .deleteItem(itemId: item.id!),
    );
  }
}

class AddItemDialog extends HookConsumerWidget {
  static void show(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(item: item),
    );
  }

  final Item item;

  const AddItemDialog({Key? key, required this.item}) : super(key: key);

  bool get isUpdating => item.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: item.name);
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
                  primary: isUpdating
                      ? Colors.orange
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  isUpdating
                      ? ref
                          .read(itemListStateProvider.notifier)
                          .updateItem(
                            updatedItem: item.copyWith(
                              name: textController.text.trim(),
                              obtained: item.obtained,
                            ),
                          )
                      : ref
                          .read(itemListStateProvider.notifier)
                          .addItem(name: textController.text.trim());
                  Navigator.of(context).pop();
                },
                child: Text(isUpdating ? 'Update' : 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemListError extends ConsumerWidget {
  final String message;

  const ItemListError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => ref
                .read(itemListStateProvider.notifier)
                .retrieveItems(isRefreshing: true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
