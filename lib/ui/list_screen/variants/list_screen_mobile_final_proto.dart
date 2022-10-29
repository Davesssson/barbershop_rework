/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/list_screen/widgets/chipSelection.dart';
import '../../../controllers/barbershop_controller/barbershop_controller.dart';
import '../../../controllers/barbershop_controller/barbershop_featured_provider.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../pagination/providers.dart';
import '../widgets/shopTile.dart';

final serviceShop = Provider<Barbershop>((_) {
  throw UnimplementedError();
});



class ListScreen_mobile_final_proto extends ConsumerWidget {
  ListScreen_mobile_final_proto({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //region ScrollController Stuff
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        //ref.read(itemsProvider.notifier).fetchNextBatch();
        //ref.read(itemsProviderMine.notifier).fetchNextBatchMine();
      }
    });
    //endregion
    return Scaffold(
/*      floatingActionButton: ScrollToTopButton(
        scrollController: scrollController,
      ),*/
      body: CustomScrollView(
        controller: scrollController,
        restorationId: "items List",
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text('List final proto Test'),
          ),
          //region ez itt opcionális
          SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Discover Budapest",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              )
          ),
          //endregion ez itt opcionális
          ItemsList2(
              stateProvider: barbershopListFeaturedStateProvider,
              contentProvider: barbershopListFeaturedContentProvider,
              shopToWatch: serviceShop
          ),
          SliverToBoxAdapter(
            child: MultiSelectionMine(ref),
          ),
          ItemsList2(
              stateProvider: barbershopListStateProvider,
              contentProvider: barbershopListContentProvider,
              shopToWatch: serviceShop
          ),
        ],
      ),
    );
  }
}

class ItemsList2 extends ConsumerWidget {
  const ItemsList2(
      {required this.stateProvider,
      required this.contentProvider,
      required this.shopToWatch,
      Key? key})
      : super(key: key);
  final StateNotifierProvider<BarbershopListStateController,
      AsyncValue<List<Barbershop>>> stateProvider;
  final Provider<List<Barbershop>> contentProvider;
  final Provider<Barbershop> shopToWatch;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(stateProvider /*barbershopListFeaturedStateProvider*/);
    return state.when(
      data: (items) {
        return items.isEmpty
            ? SliverToBoxAdapter(
                child: Column(
                  children: [
/*              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () {
                  ref.read(itemsProviderMine.notifier).fetchFirstBatch();
                },
              ),*/
                    const Chip(
                      label: Text(
                          "Nem találtunk üzleteket! Szeretné újrapróbálni?"),
                    ),
                  ],
                ),
              )
            : ItemsListBuilder2(
                contentProvider: contentProvider,
                shopToWatch:
                    shopToWatch, /*barbershopListFeaturedContentProvider*/ /*items: items*/
              );
      },
      loading: () => const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator())),
      error: (e, stk) => SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: const [
              Icon(Icons.info),
              SizedBox(
                height: 20,
              ),
              Text(
                "Something Went Wrong!",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class ItemsListBuilder2 extends ConsumerWidget {
  const ItemsListBuilder2({
    Key? key,
    required this.contentProvider,
    required this.shopToWatch,
  }) : super(key: key);
  final Provider<List<Barbershop>> contentProvider;
  final Provider<Barbershop> shopToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Barbershop> items =
        ref.watch(contentProvider */
/*barbershopListFeaturedContentProvider*//*
);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ProviderScope(
              overrides: [shopToWatch.overrideWithValue(items[index])],
              child: ShopTile(
                shopToWatch: shopToWatch,
              ));
        },
        childCount: items.length,
      ),
    );
  }
}
*/
*/