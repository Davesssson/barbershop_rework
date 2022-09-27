import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/service/service_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../controllers/service_controller/service_providers.dart';
import '../details_screen_mobile.dart';

class ServiceList extends ConsumerWidget {
  const ServiceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceListContent = ref.watch(serviceListForShopContentProvider);
    final serviceListState = ref.watch(serviceListForShopStateProvider);

    return serviceListState.when(
        data: (data) => data.isEmpty
            ? const Center(
                child: Text('sajnos nem tudtuk a szolgáltatásokat behúzni'))
            : Container(
               //color: Colors.amber,
                height: MediaQuery.of(context).size.height/9,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: serviceListContent.length,
                    itemBuilder: (BuildContext context, int index) {
                      final service = serviceListContent[index];
                      return ProviderScope(
                          overrides: [
                            currentService.overrideWithValue(service)
                          ],
                          child: serviceTile2(service: service)
                      );
                    }
                ),
              ),
        error: (e, _) => Text(e.toString()),
        loading: () => CircularProgressIndicator());
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    color: Colors.black38
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
