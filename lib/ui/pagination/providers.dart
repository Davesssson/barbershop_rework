import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/controllers/pagination/pagination_notifier.dart';


import '../../controllers/pagination/pagination_state.dart';
import '../../repositories/barbershops_repository.dart';

final itemsProvider = StateNotifierProvider<PaginationNotifier<Barbershop>, PaginationState<Barbershop>>((ref) {
      return PaginationNotifier(
        itemsPerBatch: 20,
        fetchNextItems: (barbershops) {
          return ref.read(barbershopRepositoryProvider).retrievePaginatedBarbershops(barbershops);
        },
      )..init();
    });

