import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../explorer_screen/explorer_screen.dart';
import '../item_list_screen/item_list_screen.dart';
import '../list_screen/list_screen.dart';
import '../map_screen/mapsScreenFinal2.dart';
import '../proba.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  late PersistentTabController _controller= PersistentTabController(initialIndex: 2);
  late bool _hideNavBar= false;

  List<Widget> _buildScreens() {
    return [
      //Container(color:Colors.black),
      //MainScreen2(),  //TODO PAGES HERE MUST NOT CONTAIN SCAFFOLD ||  just appbar?
      MainScreen(
        hideStatus: _hideNavBar,
      ),
      //DetailsScreen(),
      ItemListScreen(),
      //Container(color:Colors.yellow)
      ListScreen(),
      MapScreenFinal2(),
      //mapScreenMine(),
      //GeoQueryExampleMine(),
      //MapScreen(),
      ExplorerScreen()
      //MainScreen(
      //hideStatus: _hideNavBar,
      //),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems()  {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_chart_sharp),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.access_time_filled_sharp),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.h_mobiledata),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,

      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        activeColorSecondary: Colors.grey,
        inactiveColorPrimary: Colors.black,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            //'/details':(context)=>DetailsScreen(),
            //'/first': (context) => MainScreen2(),
            //'/second': (context) => MainScreen2(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search_off),
        title: ("Add"),
        activeColorPrimary: Colors.blueAccent,
        activeColorSecondary: Colors.black,
        inactiveColorPrimary: Colors.black,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            //'/details':(context)=>DetailsScreen(),
            // '/first': (context) => MainScreen2(),
            // '/second': (context) => MainScreen2(),
          },
        ),
        // onPressed: (context) {
        //   pushDynamicScreen(context!,
        //       screen: HomeScreen2(), withNavBar: true);
        // }
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.blue,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: kBottomNavigationBarHeight,
      hideNavigationBarWhenKeyboardShows: true,
      margin: EdgeInsets.all(20.0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0, //ez állítja hogy mennyire legyen a content feltolva
      //region onWillPop
      // onWillPop: (context) async {
      //   await showDialog(
      //     context: context!,
      //     useSafeArea: true,
      //     builder: (context) => Container(
      //       height: 50.0,
      //       width: 50.0,
      //       color: Colors.white,
      //       child: ElevatedButton(
      //         child: Text("Close"),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ),
      //   );
      //   return false;
      // },
      //endregion
       hideNavigationBar: MediaQuery.of(context).size.width>900,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(20.0)
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:NavBarStyle.style1, // Choose the nav bar style with this property
    );
  }
}
