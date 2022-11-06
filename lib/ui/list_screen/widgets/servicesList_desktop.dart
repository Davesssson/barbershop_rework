import 'package:flutter/material.dart' ;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../controllers/serviceTags_controller/serviceTags_providers.dart';
import '../../../controllers/service_controller/service_providers.dart';
import '../variants/list_screen_mobile_services.dart';

class ServicesListDesktop extends ConsumerWidget {
  const ServicesListDesktop({Key? key}) : super(key: key);

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
                      InkWell(
                        onTap: (){
                          ref.read(serviceTagsFilterProvider.notifier).state=[e];
                          pushNewScreenWithRouteSettings(
                            context,
                            settings: RouteSettings( name: '/services'),
                            screen: ListScreen_mobile_services(),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(radius: 60,backgroundColor: Colors.black,),
                            ),
                            Text(e.toString())
                          ],
                        ),
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