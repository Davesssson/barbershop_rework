import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/barbershop_controller.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/barber_controller.dart';
import '../../../models/item/item_model.dart';
import 'dart:developer' as developer;

import '../../list_screen/variants/list_screen_mobile_3.dart';



class DetailsScreen_mobile extends HookConsumerWidget {
  const DetailsScreen_mobile({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    final barbershopListState = ref.watch(BarbershopListControllerProvider);
    final filteredbarbershopList = ref.watch(filteredBarbershopListProvider);

    final singleBarbershopState = ref.watch(BarbershopSingleControllerProvider(arg.toString()));
    final fitleredSingleBarber = ref.watch(filteredBarbershopSingleProvider(arg.toString()));



      return singleBarbershopState.when(
          data: (data)=>Text(data.name!),
          error: (e,_)=>Text(e.toString()),
          loading: ()=>CircularProgressIndicator(),
      );


  }
}

