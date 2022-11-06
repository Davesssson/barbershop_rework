
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/explorer_object/explorer_object_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/barbershop_controller/barbershop_providers.dart';
import '../../../controllers/explorer_controller/explorer_providers.dart';
import '../../../models/barber/barber_model.dart';
import 'explorer_screen_mobile.dart';
final cindex = StateProvider<int>((ref) => 0);
final currentBarber = Provider<Barber>((_) {
  throw UnimplementedError();
});

class ExplorerScreen_web2 extends ConsumerWidget {
  ExplorerScreen_web2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final barbers = ref.watch(BarberPaginationNotifierProvider);
    final length = ref.watch(BarberPaginationNotifierProvider.notifier).items.length;
    scrollController.addListener(() {
        ref.read(BarberPaginationNotifierProvider.notifier).fetchNextBatchMine();
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        //ref.read(itemsProvider.notifier).fetchNextBatch();
        ref.read(BarberPaginationNotifierProvider.notifier).fetchNextBatchMine();
      }
    });
    return Scaffold(
      body: CustomScrollView(
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
          //endregion ez itt opcionális
          ItemsList(),
          NoMoreItems(),
          OnGoingBottomWidget(),
        ],
      ),
    );
  }
}

class ItemsList extends ConsumerWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(BarberPaginationNotifierProvider);
    return state.when(
      data: (items) {
        return items.isEmpty
            ? SliverToBoxAdapter(
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () {
                  ref.read(BarberPaginationNotifierProvider.notifier).fetchFirstBatchMine();
                },
              ),
              const Chip(
                label: Text("Nem találtunk üzleteket! Szeretné újrapróbálni?"),
              ),
            ],
          ),
        )
            : ItemsListBuilder(items: items);
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
      onGoingLoading: (items) {
        return ItemsListBuilder(
          items: items,
        );
      },
      onGoingError: (items, e, stk) {
        return ItemsListBuilder(
          items: items,
        );
      },
    );
  }
}

class ItemsListBuilder extends ConsumerWidget {
   ItemsListBuilder({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Barber> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final index = ref.watch(cindex);
      //final List<Barber>
      if(index==items.length-2){
        Future.delayed(Duration.zero,(){
          ref.read(BarberPaginationNotifierProvider.notifier).fetchNextBatchMine();
        });
      }
      final List<Explorer_object> objects = [];
      items.forEach((barber) {
        if(barber.works!=null)
        barber.works!.forEach((work) {
          objects.add(Explorer_object(barber_name: barber.name,barbershop_id: barber.barbershop_id,work_url: work));
        });
      });
      return SliverToBoxAdapter(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              itemCount: objects.length,
              itemBuilder: (context,index){
                Future.delayed(Duration.zero,(){
                  ref.read(cindex.notifier).state=index;
                });
                //final barber = items[index];
                final exp_obj = objects[index];
                return Row(
                  children: [

                    ref.watch(shopProvider(exp_obj.barbershop_id!)).when(
                        data: (data){
                          return Container(
                            width: MediaQuery.of(context).size.width/2,
                            color:Colors.blue,
                            child: Text(data.name!),
                          );
                        },
                        error: (e,_){return Text("error");},
                        loading: (){return Text("loading");}
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      color: Colors.red,
                      child: Image.network(exp_obj.work_url!,fit:BoxFit.fitWidth),
                    ),
                  ],
                );
              }
          ),
        ),
      );
/*    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProviderScope(
            overrides: [currentBarber.overrideWithValue(items[index])],
            child: Text(items[index].name!)
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
    );*/
  }
}

class NoMoreItems extends ConsumerWidget {
  const NoMoreItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(BarberPaginationNotifierProvider);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (items) {
            final nomoreItems = ref.read(BarberPaginationNotifierProvider.notifier).noMoreItems;
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

class OnGoingBottomWidget extends StatelessWidget {
  const OnGoingBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
        child: Consumer(builder: (context, ref, child) {
          final state = ref.watch(BarberPaginationNotifierProvider);
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