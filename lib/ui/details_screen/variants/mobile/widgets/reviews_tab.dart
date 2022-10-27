
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../controllers/place_controller.dart';

class Reviews extends ConsumerWidget {
  final placesId;
  const Reviews({
    required this.placesId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final detailsResponse = ref.watch(detailsResultProvider(placesId));

    return detailsResponse.when(
        data: (DetailsResponse d){
          return ListView.builder(
            itemCount: d.result!.reviews!.length,
            itemBuilder: (context,index){
              final currentReview = d.result!.reviews![index];
              return ListTile(
                //leading: Image.network(currentReview.profilePhotoUrl!),
                title: Padding(
                  padding: const EdgeInsets.only(top:3,bottom: 3),
                  child: Text(currentReview.authorName!),
                ),
                subtitle: Text(currentReview.text!),
              );

            },
          );
        } ,
        error: (e,_){return Text("fos");},
        loading: (){return CircularProgressIndicator();}
    );
  }
}