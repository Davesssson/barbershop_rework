import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../../controllers/place_controller.dart';

class buildAbout extends ConsumerWidget {
  const buildAbout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsResult = ref.watch(detailsResultProvider('ChIJP6SRA2bcQUcRd4Q6z-4PUTI'));

    return detailsResult.when(
        data: (DetailsResult d){
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.web),
                  Text(d.website!),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check_box),
                  Text("instagram.com/blacksheepbarbershopbp"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.facebook),
                  Text("www.facebook.com/blacksheepbarbershopbudapest"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone),
                  Text(d.formattedPhoneNumber!),
                ],
              ),
              Text('Opening hours'),
/*              ListView.builder(
                  itemCount: d.openingHours!.periods!.length,
                  itemBuilder: (context, index){
                    final currentPeriod = d.openingHours!.periods![index];
                    return Text(currentPeriod.open!.time!);
                  }),*/
            ],
          );
        } ,
        error: (e,_){return Text("fos");},
        loading: (){return CircularProgressIndicator();}
    );
  }
}