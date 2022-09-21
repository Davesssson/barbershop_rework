import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/city_controller/city_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../controllers/city_controller/city_providers.dart';
import '../../../models/item/item_model.dart';
import 'dart:developer' as developer;

import '../../details_screen/details_screen.dart';

final currentShop = Provider<Barbershop>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ListScreen_mobile3 extends HookConsumerWidget {
  const ListScreen_mobile3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final optionsState = ref.watch(cityListStateProvider);
    final barbershopsState = ref.watch(barbershopListStateProvider);
    final barbershopsContent = ref.watch(barbershopListContentProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(cityListFilterProvider.notifier).state = "";
          print("a beallitott allapot a barberlistanak a : """);

        },
      ),
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
                print("a beallitott allapot a barberlistanak a :");
                print(selected);
              }
          ),
          barbershopsState.when(
              data: (shops) => shops.isEmpty
              ? const Center(
                child: Text(
                  'no barbershop to display',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
              : ListView.builder(
                shrinkWrap: true,
                itemCount: barbershopsContent.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = barbershopsContent[index];
                  return ProviderScope(
                    overrides: [currentShop.overrideWithValue(item)],
                    child:  ShopTile(),
                  );
                },
              ),
              error: (error,_)=>Text("errpr in details screen"),
              loading: () => const Center(child: CircularProgressIndicator())
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