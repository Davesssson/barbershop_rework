
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../controllers/service_controller/service_providers.dart';
import '../choose_time.dart';

class servicesList extends ConsumerWidget {
  final String barbershopId;
  const servicesList({Key? key,required this.barbershopId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesForShopProvider(barbershopId));
    final selectedService = ref.watch(selectedServiceProvider);
    return services.when(
        data: (servicesForShop){
          return servicesForShop.isEmpty
              ?  Text("Az üzletnek nincsenek szolgáltatásai")
              :Column(
            children: [
              ...servicesForShop.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: (){
                      ref.read(selectedServiceProvider.notifier).state = e.id;
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    tileColor: Theme.of(context).cardColor,
                    title: Text(e.serviceTitle!),
                    subtitle: Text(e.serviceDescription!),
                    trailing: Text(e.servicePrice!.toString()),
                    selected: e.id==selectedService,
                  ),
                );
              }).toList()
            ],
          );
        },
        error: (e,_){return Text("error a szolgáltatások betöltése közben");},
        loading: (){return CircularProgressIndicator();}
    );
  }
}
