
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../../controllers/auth_controller.dart';
import '../../../../profile_screen/profile_screen.dart';

class UpperRow extends ConsumerWidget {
  const UpperRow({
    Key? key,
  }) : super(key: key);

  String greeting(){
    //5-9 reggelt
    //9-12 délelőtt
    //12-17 délutánt
    //17-20 estét
    //20-5 éjszakát
    final time = DateTime.now();
    if(time.hour>20 && time.hour<5)
      return "Szép éjszakát";
    else if(time.hour>5&&time.hour<9)
      return "Jó reggelt";
    else if(time.hour>9&&time.hour<12)
      return "Szép délelőttöt";
    else if(time.hour>12 && time. hour< 17)
      return "Szép délutánt";
    else if(time.hour >17 && time.hour < 20)
      return "Szép estét";
    else return ("Üdv");
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  greeting(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                )
            ),
          ),
        ),
        authControllerState != null?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_)=>profileScreen(),

                ),
              );
              pushNewScreenWithRouteSettings(

                context,
                settings: RouteSettings(name: '/profile'),
                screen: profileScreen(),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,
            ),
          ),
        ):TextButton(
            onPressed: () {

            },
            child: Text("Sign In!")
        )
      ],
    );
  }
}
