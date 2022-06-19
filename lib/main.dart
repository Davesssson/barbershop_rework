import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/auth_controller.dart';
import 'package:flutter_shopping_list/controllers/item_list_controller.dart';
import 'package:flutter_shopping_list/models/item_model.dart';
import 'package:flutter_shopping_list/repositories/auth_repository.dart';
import 'package:flutter_shopping_list/repositories/custom_exception.dart';
import 'package:flutter_shopping_list/ui/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Riverpod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: HomeScreen2(),
      initialRoute:'/login' ,
      routes:{
        '/login':(context)=> LoginScreen(),
        '/home':(context)=>HomeScreen2()
       } ,
    );
  }
}

class HomeScreen2 extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final isObtainedFilter = ref.watch(itemListFilterProvider.notifier).state == ItemListFilter.all;

    late TextEditingController emailController = TextEditingController();
    late TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        leading: authControllerState != null
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                    ref.read(authControllerProvider.notifier).signOut();
                    Navigator.pop(context);
              })
            : IconButton(
                icon: const Icon(Icons.abc),
                onPressed: () {}//=> ref.read(authControllerProvider.notifier).signInAnonymously(),
              ),
        actions: [
          IconButton(
            icon: Icon(
              isObtainedFilter
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            onPressed: () { //TODO NEM SZÉP, DE CSÚNYA, ERRE KI KELL TALÁLNI VALAMIT
             if(ref.watch(itemListFilterProvider.notifier).state == ItemListFilter.all){
               ref.watch(itemListFilterProvider.notifier).state = ItemListFilter.obtained ;
             }
             else
               ref.watch(itemListFilterProvider.notifier).state = ItemListFilter.all ;
              print("megnyomodtam genyo");
              print(ref.watch(itemListFilterProvider.state).state);
              },
          ),
        ],
      ),
      body: Column(
        children: [
          if (authControllerState==null)...[
            // //region show login "page"
            // TextField(
            //   controller: emailController,
            // ),
            // TextField(
            //   controller: passwordController,
            // ),
            // TextButton(
            //     onPressed: ()=>ref.watch(authControllerProvider.notifier).singInViaEmailAndPassword(emailController.text, passwordController.text),
            //     child: Text("login")
            // ),
            // TextButton(
            //     onPressed: ()=>ref.watch(authControllerProvider.notifier).createUserWithEmailAndPassword(emailController.text, passwordController.text),
            //     child: Text("register")
            // ),
            // TextButton(
            //   onPressed: ()=>ref.watch(authControllerProvider.notifier).signInAnonymously(),
            //   child: Text("continue anonymously"),
            // ),
            //
            // authControllerState!=null
            // ? Text("be vagyok jelentkezve")
            // :Text("ki vagyok jelentkezve")
            // //endregion
          ]else ...[
             ItemList(),
          ]
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
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
                          .read(itemListControllerProvider.notifier)
                          .updateItem(
                            updatedItem: item.copyWith(
                              name: textController.text.trim(),
                              obtained: item.obtained,
                            ),
                          )
                      : ref
                          .read(itemListControllerProvider.notifier)
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

final currentItem = Provider<Item>((_) => throw UnimplementedError());

class ItemList extends HookConsumerWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListState = ref.watch(itemListControllerProvider);
    final filteredItemList = ref.watch(filteredItemListProvider);
    return itemListState.when(
      data: (items) => items.isEmpty
          ? const Center(
              child: Text(
                'Tap + to add an item',
                style: TextStyle(fontSize: 20.0),
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
        message:
            error is CustomException ? error.message! : 'Something went wrong!',
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
            .read(itemListControllerProvider.notifier)
            .updateItem(updatedItem: item.copyWith(obtained: !item.obtained)),
      ),
      onTap: () => AddItemDialog.show(context, item),
      onLongPress: () => ref
          .read(itemListControllerProvider.notifier)
          .deleteItem(itemId: item.id!),
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
                .read(itemListControllerProvider.notifier)
                .retrieveItems(isRefreshing: true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
class HomeScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final itemListFilter = ref.watch(itemListFilterProvider);
    final isObtainedFilter = ref.read(itemListFilterProvider.notifier).state == ItemListFilter.obtained;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        leading: authControllerState != null
            ? IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () =>
              ref.read(authControllerProvider.notifier).signOut(),
        )
            : IconButton(
          icon: const Icon(Icons.abc),
          onPressed: () => ref
              .read(authControllerProvider.notifier)
              .signInAnonymously(),
        ),
        actions: [
          IconButton(
              icon: Icon(
                isObtainedFilter
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
              ),
              onPressed: () {
                ref.read(itemListFilterProvider.notifier).state = isObtainedFilter ? ItemListFilter.all : ItemListFilter.obtained;
                print("megnyomodtam genyo");
                print(ref.watch(itemListFilterProvider.state).state);}
          ),
        ],
      ),
      body: ItemList(),
      // body: ProviderListener(
      //   provider: itemListExceptionProvider,
      //   onChange: (
      //     BuildContext context,
      //     StateController<CustomException?> customException,
      //   ) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         backgroundColor: Colors.red,
      //         content: Text(customException.state!.message!),
      //       ),
      //     );
      //   },
      //   child: const ItemList(),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
