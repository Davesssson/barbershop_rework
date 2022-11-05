
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../choose_time.dart';

class CustomChip extends ConsumerWidget {
  const CustomChip({
    Key? key,
    required this.barberId,
    required this.ref,
    required this.start,
  }) : super(key: key);
  final String barberId;
  final WidgetRef ref;
  final DateTime start;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedChip);
    final hourDisplay = start.hour.toString().length==2? start.hour : "0"+start.hour.toString();
    return ChoiceChip(
        selected: selected?.start==this.start,
        onSelected: (selected){
          ref.read(selectedChip.notifier).state=this;
        },
        selectedColor: Theme.of(context).primaryColor,
        label: Text("${hourDisplay}:${start.minute}"));
  }
}
