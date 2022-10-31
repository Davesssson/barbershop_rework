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
            color: Colors.grey,
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    hoverColor: Colors.black,
                    onTap: (){EditServiceDialog.show(context, service);},
                    title: Text(service.serviceTitle!),
                    leading:deleteSwitchOn==true? IconButton(
                      icon:Icon(Icons.delete),
                      onPressed: (){
                        ref.read(serviceListForShopStateProvider.notifier).deleteItem(serviceId: service.id!);
                      },
                    )
                        :null,
                    trailing: Text(service.servicePrice.toString() + " Ft"),
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
