import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../../controllers/place_controller.dart';

class About extends ConsumerWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsResponse = ref.watch(detailsResultProvider('ChIJP6SRA2bcQUcRd4Q6z-4PUTI'));

    return detailsResponse.when(
        data: (DetailsResponse d){
          if( d.status=="OK")
          return ListView(
            children: [
              AboutRow(icon: Icons.web,textToDisplay: d.result!.website!,),
              AboutRow(icon: Icons.check_box,textToDisplay: "instagram.com/blacksheepbarbershopbp",),
              AboutRow(icon: Icons.feedback,textToDisplay: "www.facebook.com/blacksheepbarbershopbudapest",),
              AboutRow(icon: Icons.phone,textToDisplay: d.result!.formattedPhoneNumber!,),
              AboutRow(icon: Icons.web,textToDisplay: d.result!.website!,),
              Text('Opening hours'),
              Column(
                children: [
                  ...d.result!.openingHours!.periods!.map((period) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(period.open!.day.toString()),
                        Text(period.open!.time.toString()),
                        Text("-"),
                        Text(period.close!.time.toString())
                      ],
                    );
                    return Text(period.open.toString());
                  }).toList()
                ],
              )
            ],
          );
          else return Text("fos");
        } ,
        error: (e,_){return Text("fos");},
        loading: (){return CircularProgressIndicator();}
    );
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
      padding: const EdgeInsets.all(12.0),
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
    );
  }
}