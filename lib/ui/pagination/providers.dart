import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/pagination/pagination_notifier.dart';
import 'package:flutter_shopping_list/ui/pagination/pagination_state.dart';


import 'database.dart';

final itemsProvider = StateNotifierProvider<PaginationNotifier<Barbershop>, PaginationState<Barbershop>>(
        (ref) {
      return PaginationNotifier(
        itemsPerBatch: 20,
        fetchNextItems: (
            item,
            ) {
          return ref.read(databaseProvider).fetchItems(item);
        },
      )..init();
    });

final databaseProvider = Provider<MyDatabase>((ref) => MyDatabase());
