import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../../../models/barbershop/barbershop_model.dart';
import '../../../controllers/barber_controller/barber_providers.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../general_providers.dart';
import '../../../models/barber/barber_model.dart';
import '../../details_screen/details_screen.dart';

//https://medium.com/geekculture/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-3-scroll-to-page-30b6c43bd41

final currentShop = Provider<Barber>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ExplorerScreen_mobile extends ConsumerWidget {
  ExplorerScreen_mobile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryState = ref.watch(firebaseFirestoreProvider).collection('barbers');

    final query = queryState.withConverter<Barber>(
        fromFirestore: (snapshots,_)=>Barber.fromDocument(snapshots),
        toFirestore: (barbershop,_)=>barbershop.toJson());

    return Scaffold(
        body: Container(
            child:FirestoreQueryBuilder<Barber>(
              query: query,
              pageSize: 10,
              builder: (context,snapshot,_){
                return PageView.builder(
                  pageSnapping: true,
                  scrollDirection: Axis.vertical,
                    itemCount: snapshot.docs.length,
                    itemBuilder:(context,index){
                      if (snapshot.isFetching) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      }

                      final hasEndReached = snapshot.hasMore && index+1 == snapshot.docs.length&& !snapshot.isFetching;
                      if(hasEndReached){
                        print("most szedtem uj adatot");
                        snapshot.fetchMore();

                      }
                      final barber = snapshot.docs[index].data();
                      return ProviderScope(
                          overrides: [currentShop.overrideWithValue(barber)],
                          child: OnePage()
                      );

                    }

                );
              },
            )




          //ListView(
          // children: [
          // Autocomplete<String>(
          //     optionsBuilder: (TextEditingValue textEditingValue) async {
          //       if (textEditingValue.text == '') {
          //         return const Iterable<String>.empty();
          //       }
          //       return optionsState.when(
          //           data: (data){
          //             return data.where((String option){
          //               return option.contains(textEditingValue.text.toLowerCase());
          //             });
          //           },
          //           error: (error,_)=>const Iterable<String>.empty(),
          //           loading: () => const Iterable<String>.empty()
          //       );
          //     },
          //     onSelected:(String selected){
          //       ref.read(cityListFilterProvider.notifier).state = selected;
          //       ref.read(queryStateProvider.notifier).queryForCity(selected);
          //       print("a beallitott allapot a barberlistanak a :");
          //       print(selected);
          //     }
          // ),

          // FirestoreListView<Barbershop>(
          //   shrinkWrap: true,
          //   query: query,
          //   pageSize: 10,
          //   loadingBuilder: (context) => CircularProgressIndicator(),
          //   errorBuilder: (context, error, stackTrace) => Text(error.toString()),
          //   //key: PageStorageKey<String>('page'),
          //   itemBuilder: (context,snapshot){
          //
          //     final bs = snapshot.data();
          //
          //     return ProviderScope(
          //       overrides: [currentShop.overrideWithValue(bs)],
          //       child:  ShopTile(),
          //     );
          //   },
          // ),
          // ],
          // ),
        )
    );

  }
}

class OnePage extends HookConsumerWidget {
  const OnePage({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barber = ref.watch(currentShop);
    return Stack(
        fit:StackFit.expand,
        children: [
          Image.network(
            barber.prof_pic!,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    ref.read(barberListStateProvider.notifier).retrieveBarbersFromShop2(barber.barbershop_id!);
                    ref.read(barbershopListStateProvider.notifier).retrieveSingleBarbershop(barber.barbershop_id!);
                    List<Barbershop> b = ref.watch(barbershopListContentProvider);
/*                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=>DetailsScreen(),
                        settings: RouteSettings(
                          arguments:b[0] ,// TODO ez igy ebben a formában jo a materialRoutepage-el????
                        ),
                      ),
                    );*/

                  },
                    child: Text(barber.name!),
                )],
            ),
          )
        ]);
  }
}

// class ShopTile extends HookConsumerWidget {
//
//   const ShopTile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final barbershop = ref.watch(currentShop);
//     return Card(
//       color:Colors.grey,
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: (){
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_)=>DetailsScreen(),
//               settings: RouteSettings(
//                 arguments: barbershop.id,// TODO ez igy ebben a formában jo a materialRoutepage-el????
//               ),
//             ),
//           );
//         },
//         child: Column(
//           children: [
//             ListTile(
//               leading: CircleAvatar(backgroundImage: NetworkImage(barbershop.main_image!)),
//               title: Text(barbershop.name!,style: TextStyle(color: Colors.white70),),
//               key: ValueKey(barbershop.id),
//               subtitle: Text(
//                 "secondary",
//                 style: TextStyle(color: Colors.black.withOpacity(0.6)),
//               ),
//             ),
//
//             Container(
//                 width: double.infinity,
//                 child: Image.network(barbershop.main_image!,height: MediaQuery.of(context).size.height/4.5,fit: BoxFit.cover,))
//             //Image.asset('assets/card-sample-image-2.jpg'),
//           ],
//         ),
//       ),
//     );
//   }
// }

