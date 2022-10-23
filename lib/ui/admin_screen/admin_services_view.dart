
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
                          ListView.builder(
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
                              }),
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

class EditServiceDialog extends HookConsumerWidget {
  static void show(BuildContext context, Service service) {
    showDialog(
      context: context,
      builder: (context) => EditServiceDialog(service: service),
    );
  }

  final Service service;

  const EditServiceDialog({Key? key, required this.service}) : super(key: key);

  bool get isUpdating => service.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: service.serviceTitle);
    final descriptionController = useTextEditingController(text: service.serviceDescription);
    final priceController = useTextEditingController(text: service.servicePrice.toString());
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            TextField(
              controller: descriptionController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            TextField(
              controller: priceController,
              autofocus: true,
              decoration: const InputDecoration(hintText: '5100 '),
            ),
            Text("Ft"),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isUpdating
                      ? Colors.orange
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  isUpdating
                      ? ref
                      .read(serviceListForShopStateProvider.notifier)
                      .updateService(
                          serviceId: service.id!,
                          updatedService: service.copyWith(
                            serviceTitle: titleController.text.trim(),
                            serviceDescription: descriptionController.text.trim(),
                            servicePrice: int.parse(priceController.text.toString().trim()),
                           ),
                       )
                      :{}; ref
                      .read(serviceListForShopStateProvider.notifier)
                      .addService(
                          shopId: "7HTJ8DF8hFwUnrL566Wc",
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          price: int.parse(priceController.text.toString().trim())
                      );
                  Navigator.of(context).pop();
                },
                child: Text(isUpdating ? 'Update' : 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
