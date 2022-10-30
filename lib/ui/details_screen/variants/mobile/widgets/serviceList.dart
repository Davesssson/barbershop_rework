import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/service/service_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../controllers/service_controller/service_providers.dart';
import '../details_screen_mobile.dart';

class Services extends ConsumerWidget {
  final barbershopId;
  const Services({
    required this.barbershopId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceListState = ref.watch(servicesForShopProvider(barbershopId));

    return serviceListState.when(
        data: (data) => data.isEmpty
            ? const Center(
                child: Text('sajnos nem tudtuk a szolgáltatásokat behúzni'))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final service = data[index];
                  return ProviderScope(
                      overrides: [
                        currentService.overrideWithValue(service)
                      ],
                      child: serviceTile3(service: service)
                  );
                }
            ),
        error: (e, _) => Text(e.toString()),
        loading: () => CircularProgressIndicator());
  }
}

class serviceTile3 extends StatelessWidget {
  final Service service;
  const serviceTile3({Key? key,required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(service.serviceTitle!),
      subtitle: Text(service.serviceDescription!),
      trailing: Text(service.servicePrice.toString()),
    );
  }
}


class serviceTile2 extends StatelessWidget {
  const serviceTile2({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/10,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                child: Text(
                  service.serviceTitle.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16 , 4, 8, 4),
                child: Text(
                  service.serviceDescription.toString() ,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    color:Colors.black12
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 30),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
              ),
              color: Colors.transparent,

              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,8,16,8),
              child: Text(
                service.servicePrice.toString()+" Ft",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black38
                ) ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class serviceTile extends StatelessWidget {
  const serviceTile({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        title: Text(service.serviceTitle!),
        subtitle: Text(service.serviceDescription!),
      ),
    );
  }
}
