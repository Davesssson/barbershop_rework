
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/auth_controller.dart';
import '../list_screen/variants/web/list_screen_web.dart';
import '../profile_screen/profile_screen.dart';

class webAppBar extends ConsumerWidget with PreferredSizeWidget {
  const webAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(30,0,0,8),
        child: SvgPicture.asset("cdsgraphics-Barber-Shop-Pole.svg", color: Colors.white,),
      ),
      //leading: Icon(Icons.hail_rounded),
      toolbarHeight: 100,
      flexibleSpace: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width/2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    )
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
                      /*                     pushNewScreenWithRouteSettings(

                      context,
                      settings: RouteSettings(name: '/profile'),
                      screen: profileScreen(),
                    );*/
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ):TextButton(
                    onPressed: () {
                      GoRouter.of(context).go("/login");
                    },
                    child: Text("Sign In!")
                )

              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: (){
                      ref.read(homePageProvider.notifier).state=0;
                    },
                    child: Text("Böngéssz üzletek között!")
                ),
                TextButton(
                    onPressed: (){ref.read(homePageProvider.notifier).state=1;},
                    child: Text("Nézd meg térképen")
                ),
                TextButton(
                    onPressed: (){ref.read(homePageProvider.notifier).state=2;},
                    child: Text("Fedezd fel!")
                ),
                TextButton(
                    onPressed: (){ref.read(homePageProvider.notifier).state=3;},
                    child: Text("Légy partner!")
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}