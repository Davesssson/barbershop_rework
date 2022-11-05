import 'package:flutter/material.dart' ;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/serviceTags_controller/serviceTags_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';

class ServicesListMobile extends ConsumerWidget {
  const ServicesListMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tags =  ref.watch(ServiceTagsListStateControllerProvider);
    return tags.when(
        data: (tags){
          return SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...tags.map((e) =>
                    Container(
                      child:
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(radius: 45,backgroundColor: Colors.red,),
                          ),
                          Text(e.toString())
                        ],
                      ),

                    )
                ).toList(),
              ],
            ),
          );
        },
        error: (e,_){return Text("service List error");},
        loading: (){return CircularProgressIndicator();}
    );
  }
}