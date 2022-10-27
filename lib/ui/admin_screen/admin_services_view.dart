import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/admin_screen/widgets/editServiceDialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controllers/service_controller/service_providers.dart';
import '../../models/service/service_model.dart';

class adminServiceView extends HookConsumerWidget {
  adminServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceListContent = ref.watch(serviceListForShopContentProvider);
    final serviceListState = ref.watch(serviceListForShopStateProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
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
                          serviceList(),
                          ListTile(
                            hoverColor: Colors.black,
                            onTap: (){EditServiceDialog.show(context, Service.empty());},
                            title: Text("asd"),
                          ),
                        ],
                      ),
                    ),
                error: (e, _) => Text(e.toString()),
                loading: () => CircularProgressIndicator())));
  }
}

class serviceList extends ConsumerWidget {
  const serviceList({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceListContent = ref.watch(serviceListForShopContentProvider);

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: serviceListContent.length,
        itemBuilder: (BuildContext context, int index) {
          final service = serviceListContent[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              hoverColor: Colors.black,
              onTap: (){EditServiceDialog.show(context, service);},
              title: Text(service.serviceTitle!),
              leading: IconButton(
                icon:Icon(Icons.delete),
                onPressed: (){
                  ref.read(serviceListForShopStateProvider.notifier).deleteItem(serviceId: service.id!);
                },
              ),
              trailing: Text(service.servicePrice.toString() + " Ft"),
            ),
          );
        }
    );
  }
}
