
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
        ...tags.map((e) => ChoiceChip(
          label: Text(e),
          onSelected: (bool){
            if(bool) {
              List<String> updatingtags = [];
              service.tags!.forEach((key, value) {
                updatingtags.add(key);
              });
              ref.read(serviceListForAdminStateProvider(shopId).notifier)
                  .updateTags(service: service, tags: [...updatingtags, e]);
            }else{
              List<String> removeTags = [];
              service.tags!.forEach((key, value) {
                removeTags.add(key);
              });
              ref.read(serviceListForAdminStateProvider(shopId).notifier)
                  .updateTags(service: service, tags: [...removeTags..remove(e)]);
            }
            //service.tags!.addAll({e:value});
          },
          selectedColor: Theme.of(context).primaryColor,
          selected: service.tags==null? false : service.tags!.keys.contains(e),
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