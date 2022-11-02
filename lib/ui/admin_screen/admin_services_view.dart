import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/admin_screen/widgets/editServiceDialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controllers/service_controller/service_providers.dart';
import '../../models/service/service_model.dart';

final deleteSwitcherProvider = StateProvider<bool>((_) => false);

class adminServiceView extends HookConsumerWidget {
  final String shopId;
  adminServiceView({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceListState = ref.watch(serviceListForAdminStateProvider(shopId));
    final deleteSwitch = ref.watch(deleteSwitcherProvider);
    return Scaffold(
        body: Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            color: Theme.of(context).cardColor,
            child: serviceListState.when(
                data: (data) => data.isEmpty
                    ? const Center(
                        child: Text(
                            'sajnos nem tudtuk a szolgáltatásokat behúzni'))
                    : SingleChildScrollView(
                      child: Column(
                        children: [
                          serviceList(shopId: shopId),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(Icons.add),
                              hoverColor: Colors.black,
                              onTap: (){EditServiceDialog.show(context, Service.empty());},
                              title: Text("Adj hozzá új szolgáltatást!"),
                            ),
                          ),
                          Row(
                            children: [
                              Text("Delete Services : "),
                              Switch(
                                value: deleteSwitch,
                                activeColor: Colors.blueAccent,
                                onChanged: (value){
                                  ref.read(deleteSwitcherProvider.notifier).state=value;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                error: (e, _) => Text(e.toString()),
                loading: () => CircularProgressIndicator())
        )
    );
  }
}

class serviceList extends ConsumerWidget {
  final String shopId;
  const serviceList({
    Key? key,
    required this.shopId
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceListContent = ref.watch(serviceListForAdminStateProvider(shopId));
    final deleteSwitchOn = ref.watch(deleteSwitcherProvider);
    final serviceTags = ref.watch(serviceTagsProvider);

    return serviceListContent.when(
        data: (services){
          return services.isEmpty
              ? Text("nincsenek servicek")
              :ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: services.length,
              itemBuilder: (BuildContext context, int index) {
                final service = services[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        hoverColor: Colors.black,
                        onTap: (){EditServiceDialog.show(context, service);},
                        title: Text(service.serviceTitle!),
                        subtitle: Text(service.serviceDescription!),
                        leading:deleteSwitchOn==true? IconButton(
                          icon:Icon(Icons.delete),
                          onPressed: (){
                            ref.read(serviceListForShopStateProvider.notifier).deleteItem(serviceId: service.id!);
                          },
                        )
                            :null,
                        trailing: Text(service.servicePrice.toString() + " Ft"),
                      ),
                      serviceTags.when(
                          data: (data){
                            return serviceTagsList(service: service, tags: data,shopId:shopId);
                          },
                          error: (e,_){return Text("hiba");},
                          loading:(){return CircularProgressIndicator();}
                      )
                    ],
                  ),
                );
              }
          );
        },
        error: (e,_){return Text("Error");},
        loading: (){return CircularProgressIndicator();}
    );

  }
}

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
        ).toList()
      ],
    );
  }
}
