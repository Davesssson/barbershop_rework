import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/home_screen.dart';
import 'package:flutter_shopping_list/ui/proba.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../controllers/auth_controller.dart';
import '../controllers/item_list_controller.dart';



class NavBar extends HookConsumerWidget {
  late PersistentTabController _controller= PersistentTabController(initialIndex: 0);
  late bool _hideNavBar= false;

  List<Widget> _buildScreens() {
    return [
      HomeScreen2(),  //TODO PAGES HERE MUST NOT CONTAIN SCAFFOLD ||  just appbar?
      MainScreen(
        hideStatus: _hideNavBar,
      ),
      MainScreen(
        hideStatus: _hideNavBar,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems()  {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => HomeScreen2(),
            '/second': (context) => HomeScreen2(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.blueAccent,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: Colors.white,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/first': (context) => HomeScreen2(),
              '/second': (context) => HomeScreen2(),
            },
          ),
          onPressed: (context) {
            pushDynamicScreen(context!,
                screen: HomeScreen2(), withNavBar: true);
          }),


    ];
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final isObtainedFilter =
        ref.watch(itemListFilterProvider.notifier).state == ItemListFilter.all;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        leading: authControllerState != null
            ? IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              Navigator.popAndPushNamed(context, '/login');
              //Navigator.pushNamed(context, '/login');
            })
            : IconButton(
            icon: const Icon(Icons.abc),
            onPressed:
                () {} //=> ref.read(authControllerProvider.notifier).signInAnonymously(),
        ),
        actions: [
        IconButton(
              icon: Icon(
                isObtainedFilter
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
              ),
              onPressed: () {
                //TODO NEM SZÉP, DE CSÚNYA, ERRE KI KELL TALÁLNI VALAMIT
                if (ref.watch(itemListFilterProvider.notifier).state ==
                    ItemListFilter.all) {
                  ref.watch(itemListFilterProvider.notifier).state =
                      ItemListFilter.obtained;
                } else
                  ref.watch(itemListFilterProvider.notifier).state =
                      ItemListFilter.all;
                print("megnyomodtam genyo");
                print(ref.watch(itemListFilterProvider.state).state);
              },
            ),
        ],
      ),
      //appBar: AppBar(title: const Text('Navigation Bar Demo')),
      //region drawer
      // drawer: Drawer(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text('This is the Drawer'),
      //       ],
      //     ),
      //   ),
      // ),
      //endregion
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: ElevatedButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.circular(20.0)),
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
        navBarStyle:
        NavBarStyle.style1, // Choose the nav bar style with this property
      ),
    );
  }
}