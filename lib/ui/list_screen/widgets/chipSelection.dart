import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/city_controller/city_controller.dart';
import '../../../controllers/service_controller/service_providers.dart';


ChipsChoice<String> MultiSelectionMine( WidgetRef ref) {

  final tags = ref.watch(serviceTagsProvider);
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
  ];
  final choosenServiceTags = ref.watch(serviceTagsFilterProvider);
  return ChipsChoice<String>.multiple(
    value: choosenServiceTags,
    onChanged: (val) => {
      ref.read(serviceTagsFilterProvider.notifier).state = val,
      print("ezek vannak elvileg kijelolve serviceTagsFilterProvider.notifier.state" +
          ref.read(serviceTagsFilterProvider.notifier)
              .state
              .toString())
    },
    choiceItems: C2Choice.listFrom<String, String>(
      source: tags.when(
          data:(tags) =>tags,
          error: (e, stk)=> [],
          loading: () => []
      ),
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