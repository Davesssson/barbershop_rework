import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;

import '../../../controllers/city_controller.dart';
import '../../../controllers/query_controller.dart';
import '../../../models/barbershop/barbershop_model.dart';
import '../../details_screen/details_screen.dart';

final currentShop = Provider<Barbershop>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ListScreen_mobile5 extends ConsumerWidget {
  ListScreen_mobile5({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryState = ref.watch(queryStateProvider);
    final optionsState = ref.watch(cityListStateProvider);

    final query = queryState.withConverter<Barbershop>(
        fromFirestore: (snapshots,_)=>Barbershop.fromDocument(snapshots),
        toFirestore: (barbershop,_)=>barbershop.toJson());

    return Scaffold(
      body: Column(
        children: [
          Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return optionsState.when(
                    data: (data){
                      return data.where((String option){
                        return option.contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    error: (error,_)=>const Iterable<String>.empty(),
                    loading: () => const Iterable<String>.empty()
                );
              },
              onSelected:(String selected){
                ref.read(cityListFilterProvider.notifier).state = selected;
                ref.read(queryStateProvider.notifier).queryForCity(selected);
                print("a beallitott allapot a barberlistanak a :");
                print(selected);
              }
          ),
          FirestoreListView<Barbershop>(
            shrinkWrap: true,
            query: query,
            pageSize: 3,
            loadingBuilder: (context) => CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) => Text(error.toString()),
            itemBuilder: (context,snapshot){
              final bs = snapshot.data();

              return ProviderScope(
                overrides: [currentShop.overrideWithValue(bs)],
                child:  ShopTile(),
              );
            },
          ),
        ],
      ),

    );

  }
}

class ShopTile extends HookConsumerWidget {
  const ShopTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(currentShop);
    return InkWell(
      onTap: (){
        //Navigator.pushNamed(context, '/details', arguments: barbershop.id!.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(),
            settings: RouteSettings(
              arguments: barbershop.id,// TODO ez igy ebben a formában jo a materialRoutepage-el????
            ),
          ),
        );
      }, //TODO ITT KELL MEGADNI HOGY MILYEN APARMÉTERT ADUNK ÁT ÉS ARRA KELL FETCHELNI A DETAILSBAN
      child: ListTile(
        key: ValueKey(barbershop.id), //ez nemtudom mit csinal
        title: Text(barbershop.name!),
        subtitle: Text(barbershop.city!),
      ),
    );
  }
}