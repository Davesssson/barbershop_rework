import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/servicesList_desktop.dart';

class ListScreen_web extends ConsumerWidget {
  const ListScreen_web({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(color:Colors.red, height: 300,child: ServicesListDesktop(),),
          Container(color:Colors.black26, height: 300,),
          Container(color:Colors.white, height: 300,),
          Container(color:Colors.green, height: 300,),
        ],
      ),
    );
  }
}

