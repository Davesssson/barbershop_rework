import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/list_screen/widgets/chipSelection.dart';
import '../../../controllers/barbershop_controller/barbershop_featured_provider.dart';
import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../pagination/providers.dart';
import '../widgets/shopTile.dart';

final currentShop5 = Provider<Barbershop>((_) {
  throw UnimplementedError();
});

final currentShop6 = Provider<Barbershop>((_) {
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
                      style: TextStyle(
                        fontSize: 35
                      ),
                  ),
                ),
              )
          ),
          ItemsList2(),


          SliverToBoxAdapter(
            child: MultiSelectionMine(ref),
          ),
          //endregion ez itt opcionális
          ItemsList(),
        ],
      ),
    );
  }
}


class ItemsList extends ConsumerWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(barbershopListStateProvider);
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
                label: Text("Nem találtunk üzleteket! Szeretné újrapróbálni?"),
              ),
            ],
          ),
        )
            : ItemsListBuilder(/*items: items*/);
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

class ItemsList2 extends ConsumerWidget {

  const ItemsList2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(barbershopListFeaturedStateProvider);
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
                label: Text("Nem találtunk üzleteket! Szeretné újrapróbálni?"),
              ),
            ],
          ),
        )
            : ItemsListBuilder2(/*items: items*/);
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

class ItemsListBuilder extends ConsumerWidget {
  const ItemsListBuilder({
    Key? key,
    //required this.items,
  }) : super(key: key);

  //final List<Barbershop> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Barbershop> items = ref.watch(barbershopListContentProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProviderScope(
            overrides: [currentShop5.overrideWithValue(items[index])],
            child: ShopTile()
        );

        // return Container(
        //   height: 300,
        //   child: ListTile(
        //     title: Text("Item ${index + 1}"),
        //   ),
        // );
      },
        childCount: items.length,
      ),
    );
  }
}



class ItemsListBuilder2 extends ConsumerWidget {
  const ItemsListBuilder2({
    Key? key,
    //required this.items,
  }) : super(key: key);

  //final List<Barbershop> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Barbershop> items = ref.watch(barbershopListFeaturedContentProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProviderScope(
            overrides: [currentShop6.overrideWithValue(items[index])],
            child: ShopTile2()
        );

        // return Container(
        //   height: 300,
        //   child: ListTile(
        //     title: Text("Item ${index + 1}"),
        //   ),
        // );
      },
        childCount: items.length,
      ),
    );
  }
}


