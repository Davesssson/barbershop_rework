import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/home_screen.dart';
import 'package:flutter_shopping_list/ui/login_screen.dart';
import 'package:flutter_shopping_list/ui/navbar.dart';
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
        '/home':(context)=>HomeScreen2(),
        '/navbar':(context)=>NavBar()
       } ,
    );
  }
}

//region old_implementation
// class HomeScreen extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authControllerState = ref.watch(authControllerProvider);
//     final itemListFilter = ref.watch(itemListFilterProvider);
//     final isObtainedFilter = ref.read(itemListFilterProvider.notifier).state == ItemListFilter.obtained;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shopping List'),
//         leading: authControllerState != null
//             ? IconButton(
//           icon: const Icon(Icons.logout),
//           onPressed: () =>
//               ref.read(authControllerProvider.notifier).signOut(),
//         )
//             : IconButton(
//           icon: const Icon(Icons.abc),
//           onPressed: () => ref
//               .read(authControllerProvider.notifier)
//               .signInAnonymously(),
//         ),
//         actions: [
//           IconButton(
//               icon: Icon(
//                 isObtainedFilter
//                     ? Icons.check_circle
//                     : Icons.check_circle_outline,
//               ),
//               onPressed: () {
//                 ref.read(itemListFilterProvider.notifier).state = isObtainedFilter ? ItemListFilter.all : ItemListFilter.obtained;
//                 print("megnyomodtam genyo");
//                 print(ref.watch(itemListFilterProvider.state).state);}
//           ),
//         ],
//       ),
//       body: ItemList(),
//       // body: ProviderListener(
//       //   provider: itemListExceptionProvider,
//       //   onChange: (
//       //     BuildContext context,
//       //     StateController<CustomException?> customException,
//       //   ) {
//       //     ScaffoldMessenger.of(context).showSnackBar(
//       //       SnackBar(
//       //         backgroundColor: Colors.red,
//       //         content: Text(customException.state!.message!),
//       //       ),
//       //     );
//       //   },
//       //   child: const ItemList(),
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => AddItemDialog.show(context, Item.empty()),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//endregion
