import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_services_screen/widgets/addNewServiceTagDialog.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_services_screen/widgets/editServiceDialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../controllers/serviceTags_controller/serviceTags_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';
import '../../../models/service/service_model.dart';
import 'widgets/serviceList.dart';

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
