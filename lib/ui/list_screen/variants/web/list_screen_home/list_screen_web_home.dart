import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../widgets/servicesList_desktop.dart';
import '../../list_screen_mobile_services.dart';
import '../list_screen_web.dart';
import 'widgets/horizontalListWeb.dart';


class list_screen_home_web extends StatelessWidget {
  const list_screen_home_web({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
                children:[
                  Container(height: 300, width:MediaQuery.of(context).size.width, child:Image.asset("hair-spies-TNhm6uVurpU-unsplash.jpg",fit: BoxFit.fitWidth,)),
                  Center(child: ServicesListDesktop())
                ]
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Near You shops for you", style: TextStyle(fontSize: 40,fontFamily: "Roboto"),),
            ),
            TextButton(
                onPressed: (){
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings( name: '/services'),
                    screen: ListScreen_mobile_services(),
                  );
                },
                child: Text("sea all")
            ),
            HorizontalListWeb(),
          ],
        ),
      ),
    );
  }
}

