import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller.dart';
import 'package:flutter_shopping_list/controllers/city_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/pagination/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../details_screen/details_screen.dart';

final currentShop3 = Provider<Barbershop>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ListScreen_mobile_pagination_mine extends HookConsumerWidget {
   ListScreen_mobile_pagination_mine({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        ref.read(itemsProvider.notifier).fetchNextBatch();
      }
    });

    final barbershopsState = ref.watch(itemsProvider);
    final barbershopsContent = ref.watch(itemsContentProvider);

    return Scaffold(
      body: ListView(
        children: [
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
                    overrides: [currentShop3.overrideWithValue(item)],
                    child:  ShopTile(),
                  );
                },
              ),
              error: (error,_)=>Text("errpr in details screen"),
              loading: () => const Center(child: CircularProgressIndicator()),
              onGoingError: (items,e,stk){
                return SizedBox();
              },
              onGoingLoading: (items){
                return SizedBox();
              }
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
    final barbershop = ref.watch(currentShop3);
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
      child: Container(
        height: 500,
        child: ListTile(
          key: ValueKey(barbershop.id), //ez nemtudom mit csinal
          title: Text(barbershop.name!),
          subtitle: Text(barbershop.city!),
        ),
      ),
    );
  }
}