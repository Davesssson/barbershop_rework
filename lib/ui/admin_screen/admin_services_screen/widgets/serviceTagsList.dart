
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'addNewServiceTagDialog.dart';
import '../../../../controllers/service_controller/service_providers.dart';
import '../../../../models/service/service_model.dart';

class serviceTagsList extends ConsumerWidget {
  final String shopId;
  final List<String> tags;
  final Service service;
  serviceTagsList({Key? key,required this.service, required this.tags, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(service.tags);
    return Row(
      children: [
        ...tags.map((tag) => ChoiceChip(
          label: Text(tag),
          onSelected: (bool){
            if(bool) {
              List<String> updatingtags = [];
              service.tags!.forEach((key, value) {
                updatingtags.add(key);
              });
              ref.read(serviceListForAdminStateProvider(shopId).notifier)
                  .updateTags(service: service, tags: [...updatingtags, tag]);
            }else{
              List<String> removeTags = [];
              service.tags!.forEach((key, value) {
                removeTags.add(key);
              });
              ref.read(serviceListForAdminStateProvider(shopId).notifier)
                  .updateTags(service: service, tags: [...removeTags..remove(tag)]);
            }
            //service.tags!.addAll({e:value});
          },
          selectedColor: Theme.of(context).primaryColor,
          selected: service.tags==null? false : service.tags!.keys.contains(tag),
        )
        ).toList(),
        ChoiceChip(
            label: Text("Add new"),
            selected:false,
            onSelected: (selected){
              addNewServiceTagDialog.show(context, service);
            }
        )
      ],
    );
  }
}