import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/barberList.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/header.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/widgets/serviceList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../../../models/barber/barber_model.dart';
import '../../../../models/service/service_model.dart';

class DetailsScreen_mobile extends HookConsumerWidget {
  const DetailsScreen_mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Barbershop barbershop =
        ModalRoute.of(context)?.settings.arguments as Barbershop;

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
    //TODO EZT KELL ÁTÍRNI ÚGY, HOGY A WIDGET BUILDELJEN, CSAK AZ ADOTT KONTÉNER MUTASSON MÁST
    return ListView(children: [
      Header(bs: bs),
      Container(
        height: 50,
        color: Colors.red,
        child: Text("Ide jon még az elérhetőség"),
      ),
      buildCoworkers(),
      BarberList(),
      buildServices(),
      ServiceList(),
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
    ]);
  }

  Padding buildServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Szolgáltatások",
            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                fontWeight: FontWeight.bold,
                color: Colors.white60,
                fontSize: 30),
          )),
    );
  }

  Padding buildCoworkers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Munkatársak",
            style: GoogleFonts.notoSansAnatolianHieroglyphs(
                fontWeight: FontWeight.bold,
                color: Colors.white60,
                fontSize: 30),
          )),
    );
  }
}

final currentBarber = Provider<Barber>((_) {
  developer.log("[item_list_screen_mobile.dart][currentItem] - ??????.");
  throw UnimplementedError();
});

final currentService = Provider<Service>((_) {
  developer.log("[.dart][currentItem] - ??????.");
  throw UnimplementedError();
});
