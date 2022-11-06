import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/map_screen/map_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../admin_screen/admin_register.dart';
import '../../../explorer_screen/variants/explorer_screen_web_2.dart';
import '../../../widgets/web_appBar.dart';
import 'list_screen_home/list_screen_web_home.dart';

//https://www.etsy.com/?ref=lgo

final homePageProvider = StateProvider<int>((_) => 0);

class ListScreen_web extends ConsumerWidget {
  ListScreen_web({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(homePageProvider);

    List<Widget> _buildScreens(){
      return [
        list_screen_home_web(),
        MapScreen(),
        ExplorerScreen_web2(),
        adminRegisterScreen()
      ];
    }

   return Scaffold(
      appBar: webAppBar(),
      body: _buildScreens()[page]
    );
  }
}