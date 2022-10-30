import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../../controllers/place_controller.dart';

class About extends ConsumerWidget {
  final placesId;
  const About({
    required this.placesId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsResponse = ref.watch(detailsResultProvider(placesId));

    return detailsResponse.when(
        data: (DetailsResponse d){
          if( d.status=="OK")
          return ListView(
            children: [
              AboutRow2(icon: Icons.web,textToDisplay: d.result!.website!,),
              AboutRow2(icon: Icons.check_box,textToDisplay: "instagram.com/blacksheepbarbershopbp",),
              AboutRow2(icon: Icons.feedback,textToDisplay: "www.facebook.com/blacksheepbarbershopbudapest",),
              AboutRow2(icon: Icons.phone,textToDisplay: d.result!.formattedPhoneNumber!,),
              AboutRow2(icon: Icons.web,textToDisplay: d.result!.website!,),
              Text('Opening hours',),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...d.result!.openingHours!.periods!.map((period) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(getNameOfDayAsString(period.open!.day!) +" "+ period.open!.time.toString() + "-" + period.close!.time.toString() ),
                          ),
                        ],
                      );
                      return Text(period.open.toString());
                    }).toList()
                  ],
                ),
              )
            ],
          );
          else return Text("fos");
        } ,
        error: (e,_){return Text("fos");},
        loading: (){return CircularProgressIndicator();}
    );
  }

  String getNameOfDayAsString(int id){
    switch(id){
      case 0:return "Hétfő";
      case 1:return "Kedd";
      case 2:return "Szerda";
      case 3:return "Csütörtök";
      case 4:return "Péntek";
      case 5:return "Szombat";
      case 6:return "Vasárnap";
      default: return "Nem értelmezhető";
    }
  }
}



class AboutRow extends StatelessWidget {
  final IconData icon;
  final String textToDisplay;
  const AboutRow({
    required this.icon,
    required this.textToDisplay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 8,0),
              child: Icon(icon, size: 30,),
            ),
            Text(textToDisplay),
          ],
        ),
      ),
    );
  }
}

class AboutRow2 extends StatelessWidget {
  final IconData icon;
  final String textToDisplay;
  const AboutRow2({
    required this.icon,
    required this.textToDisplay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        leading: Icon(icon),
        title: Text(textToDisplay),
      ),
    );
  }
}