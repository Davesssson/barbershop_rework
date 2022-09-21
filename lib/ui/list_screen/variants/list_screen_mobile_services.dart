import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/controllers/barber_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/list_screen/widgets/chipSelection.dart';

import '../../../controllers/barber_controller/barbershop_controller.dart';
import '../../pagination/providers.dart';
import '../widgets/shopTile.dart';

final currentShop4 = Provider<Barbershop>((_) {
  throw UnimplementedError();
});

class ListScreen_mobile_services extends ConsumerWidget {
  ListScreen_mobile_services({Key? key}) : super(key: key);

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
      floatingActionButton: ScrollToTopButton(
        scrollController: scrollController,
      ),
      body: CustomScrollView(
        controller: scrollController,
        restorationId: "items List",
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: Text('Infinite Pagination asd'),
          ),
          //region ez itt opcionális
          SliverToBoxAdapter(
              child: Container(
                color: Colors.red,
                height: 20,
              )
          ),
          SliverToBoxAdapter(
            child: MultiSelectionMine(ref),
          ),
          //endregion ez itt opcionális
          ItemsList(),
          //NoMoreItems(),
          //OnGoingBottomWidget(),
        ],
      ),
    );
  }
}

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemsProviderMine);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (items) {
            final nomoreItems = ref.read(itemsProviderMine.notifier).noMoreItems;
            return nomoreItems
                ? const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Ennyi üzlettel tudunk szolgálni",
                textAlign: TextAlign.center,
              ),
            )
                : const SizedBox.shrink();
            //: const SizedBox(height: 200,);
          }),
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
/*      onGoingLoading: (items) {
        return ItemsListBuilder(
          items: items,
        );
      },*/
/*      onGoingError: (items, e, stk) {
        return ItemsListBuilder(
          items: items,
        );
      },*/
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
            overrides: [currentShop4.overrideWithValue(items[index])],
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

class OnGoingBottomWidget extends StatelessWidget {
  const OnGoingBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
        child: Consumer(builder: (context, ref, child) {
          final state = ref.watch(itemsProviderMine);
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            onGoingLoading: (items) =>
            const Center(child: CircularProgressIndicator()),
            onGoingError: (items, e, stk) => Center(
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
          );
        }),
      ),
    );
  }
}
//region ScrollToTopButton
class ScrollToTopButton extends StatelessWidget {
  const ScrollToTopButton({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double scrollOffset = scrollController.offset;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: scrollOffset > MediaQuery.of(context).size.height * 0.5
              ? FloatingActionButton(
            tooltip: "Scroll to top",
            child: const Icon(
              Icons.arrow_upward,
            ),
            onPressed: () async {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
//endregion ScrollToTopButton

