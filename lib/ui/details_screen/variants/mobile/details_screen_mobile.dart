import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/controllers/service_controller/service_providers.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/barberHead.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/barberList.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../../../controllers/barber_controller/barber_providers.dart';
import '../../../../models/barber/barber_model.dart';
import '../../../../models/service/service_model.dart';

class DetailsScreen_mobile extends HookConsumerWidget {
  const DetailsScreen_mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Barbershop barbershop = ModalRoute.of(context)?.settings.arguments as Barbershop;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: DetailWidget_mobile(bs: barbershop));
  }
}

class DetailWidget_mobile extends ConsumerWidget {
  final Barbershop bs;
  const DetailWidget_mobile({Key? key, required this.bs}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbersState = ref.watch(barberListStateProvider);
    final servicesState = ref.watch(serviceListStateProvider);
    final List<Service> items = ref.watch(serviceListContentProvider);

    //TODO EZT KELL ÁTÍRNI ÚGY, HOGY A WIDGET BUILDELJEN, CSAK AZ ADOTT KONTÉNER MUTASSON MÁST
    return barbersState.when(
      data: (data) => data.isEmpty
          ? const Center(
              child: Text(
                  "sajnos a barbereket nem sikerült betölteni, vagy üresek"),
            )
          : ListView(children: [
              Header(bs: bs),
              Container(
                height: 50,
                color: Colors.red,
                child: Text("Ide jon még az elérhetőség"),
              ),
              ServiceList (barbershop: bs),
              BarberList(
                  barbershop: bs,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Munkatársak",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                          fontSize: 16),
                    )),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        color: Colors.red,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        color: Colors.green,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        color: Colors.grey,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        color: Colors.green,
                      ),
                    ],
                  )),
              Container(
                height: 300,
                color: Colors.red,
              ),
              Container(
                height: 300,
                color: Colors.blue,
              ),
              Container(
                height: 300,
                color: Colors.green,
              ),
            ]),
      error: (e, _) => Text(e.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}



class ServiceList extends ConsumerWidget {
  const ServiceList({
    Key? key,
    required this.barbershop,
  }) : super(key: key);

  final Barbershop barbershop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final serviceListContent = ref.watch(serviceListContentProvider);

    return Container(
      height: 151,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: serviceListContent.length,
          itemBuilder: (BuildContext context, int index) {
            final service = serviceListContent[index];
            return Text(service.servicePrice.toString());
            //return Text(barber.name!);
          }
      ),
    );
  }
}




final currentBarber = Provider<Barber>((_) {
  developer.log("[item_list_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});
