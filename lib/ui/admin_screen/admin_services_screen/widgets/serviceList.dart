import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../controllers/serviceTags_controller/serviceTags_providers.dart';
import '../../../../controllers/service_controller/service_providers.dart';
import '../admin_services_view.dart';
import 'editServiceDialog.dart';
import 'serviceTagsList.dart';

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
    final serviceTags = ref.watch(ServiceTagsListStateControllerProvider);

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
                            return
                              serviceTagsList(service: service, tags: data,shopId:shopId);

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