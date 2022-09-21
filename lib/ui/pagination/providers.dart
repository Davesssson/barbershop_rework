import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/controllers/pagination/pagination_notifier.dart';
import '../../controllers/pagination/pagination_notifier_mine.dart';
import '../../controllers/pagination/pagination_state.dart';
import '../../repositories/barbershops_repository.dart';

final itemsContentProvider = Provider<List<Barbershop>>((ref) {
  final barbershopsListState = ref.watch(itemsProvider);

  return barbershopsListState.maybeWhen(
    data: (shops) {
        return shops;
    },
    orElse: () => [],
  );
});

final itemsProviderMine = StateNotifierProvider<PaginationNotifierMine, PaginationState<Barbershop>>((ref) {
  return PaginationNotifierMine(ref.read);
});


final itemsProvider = StateNotifierProvider<PaginationNotifier<Barbershop>, PaginationState<Barbershop>>((ref) {
      return PaginationNotifierClass(ref.read);
    });

class PaginationNotifierClass extends PaginationNotifier<Barbershop>{
  final Reader _read;
  PaginationNotifierClass(this._read):super(
      itemsPerBatch: 3,
      fetchNextItems: (barbershops ) {
        return _read(barbershopRepositoryProvider).retrievePaginatedBarbershops(barbershops);
      },
    ){
    this.init();
  }

  Future<void> fetchMore() async{
    final item = await _read(barbershopRepositoryProvider).retrievePaginatedBarbershops(this.items.last);
    state = PaginationState.data(item);

  }





}

