import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller/barbershop_featured_provider.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/list_screen_mobile_final_proto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/barbershop_controller/barbershop_controller.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../controllers/city_controller/city_providers.dart';
import 'dart:developer' as developer;
import '../../details_screen/details_screen.dart';
import '../widgets/shopTile.dart';
import '../widgets/shopTile3.dart';

final currentShop_final = Provider<Barbershop>((_) {
  developer.log("[details_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

class ListScreen_mobile_final extends HookConsumerWidget {
  const ListScreen_mobile_final({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final optionsState = ref.watch(cityListStateProvider);
    final barbershopsFeaturedState = ref.watch(barbershopListFeaturedStateProvider);
    final barbershopsFeaturedContent = ref.watch(barbershopListFeaturedContentProvider);
    final barbershopsNearYouState = ref.watch(barbershopListStateProvider);
    final barbershopsNearYouContent = ref.watch(barbershopListContentProvider);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Discover _______",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black,

                ),
              )
            ),
          ),
          SizedBox(height: 25),
          barbershopsFeaturedState.when(
              data: (shops) => shops.isEmpty
                  ? const Center(
                child: Text(
                  'no barbershop to display',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
                  : SizedBox(
                height: MediaQuery.of(context).size.height/3,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: barbershopsFeaturedContent.length,
                  separatorBuilder: (context, index){
                    return const SizedBox(width: 20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = barbershopsFeaturedContent[index];
                    return ProviderScope(
                        overrides: [currentShop_final.overrideWithValue(item)],
                        child: Hero(tag:'asd',child: ShopTile3(shopToWatch:currentShop_final))
                    );
                  },
                ),
              ),
              error: (error,_)=>Text("errpr in details screen"),
              loading: () => const Center(child: CircularProgressIndicator())
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Near you",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,

                  ),
                )
            ),
          ),
          barbershopsNearYouState.when(
              data: (shops) => shops.isEmpty
                  ? const Center(
                child: Text(
                  'no barbershop to display',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
                  : SizedBox(
                height: MediaQuery.of(context).size.height/3,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: barbershopsNearYouContent.length,
                  separatorBuilder: (context, index){
                    return const SizedBox(width: 20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = barbershopsNearYouContent[index];
                    return ProviderScope(
                        overrides: [currentShop_final.overrideWithValue(item)],
                        child: ShopTile3(shopToWatch:currentShop_final)
                    );
                  },
                ),
              ),
              error: (error,_)=>Text("errpr in details screen"),
              loading: () => const Center(child: CircularProgressIndicator())
          ),
          HorizontalList(
              stateProvider:barbershopListStateProvider ,
              contentProvider: barbershopListContentProvider,
              shopToWatch: featuredShop
          )


        ],
      ),

    );
  }
}

class HorizontalList extends ConsumerWidget{
  const HorizontalList({
    Key? key,
    required this.stateProvider,
    required this.contentProvider,
    required this.shopToWatch,
  }) : super(key: key);

  final StateNotifierProvider<BarbershopListStateController, AsyncValue<List<Barbershop>>> stateProvider;
  final Provider<List<Barbershop>> contentProvider;
  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = ref.watch(this.stateProvider);
    final contentProvider = ref.watch(this.contentProvider);

    return stateProvider.when(
        data: (data){
          return data.isEmpty
              ? SizedBox(height: 100, child: Text("Sanjnos nincsen adat a horizontalList-ben"),)
              : SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: contentProvider.length,
                    separatorBuilder: (context, index){
                      return const SizedBox(width: 20);
                    },
                    itemBuilder: (context, index) {
                      final barbershop = contentProvider[index];
                      return ProviderScope(
                          overrides: [shopToWatch.overrideWithValue(barbershop)],
                          child: ShopTile3(shopToWatch:shopToWatch)
                      );
                    },
                  ),
                );
        },
        error: (error,_)=>Text("errpr in details screen"),
        loading: () => const Center(child: CircularProgressIndicator())
    );
  }

}
