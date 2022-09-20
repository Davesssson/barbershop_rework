import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/repositories/service_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/city_controller.dart';
import '../../../controllers/service_controller.dart';


ChipsChoice<String> MultiSelectionMine( WidgetRef ref) {

  List<String> options2 = ref.watch(serviceTagsListProvider);
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
  ];
  final chipList = ref.watch(chipListFilterProvider);
  return ChipsChoice<String>.multiple(
    value: chipList,
    onChanged: (val) => {
      ref.read(chipListFilterProvider.notifier).state = val,
      print("ezek vannak elvileg kijelolve " +
          ref.read(chipListFilterProvider.notifier)
              .state
              .toString())
    },
    choiceItems: C2Choice.listFrom<String, String>(
      source: options2,
      value: (i, v) => v,
      label: (i, v) => v,
    ),
    choiceStyle: C2ChoiceStyle(
      color: Colors.orange,
      borderColor: Colors.red,
    ),
    wrapped: true,
    textDirection: TextDirection.ltr,
  );
}