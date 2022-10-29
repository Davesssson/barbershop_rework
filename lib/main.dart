import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/constants/route_paths.dart';
import 'package:flutter_shopping_list/constants/theme_data.dart';
import 'package:flutter_shopping_list/controllers/theme_controller.dart';
import 'package:flutter_shopping_list/ui/admin_screen/admin_screen.dart';
import 'package:flutter_shopping_list/ui/details_screen/details_screen.dart';
import 'package:flutter_shopping_list/ui/home_screen.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/list_screen_mobile_services.dart';
import 'package:flutter_shopping_list/ui/login_screen/login_screen.dart';
import 'package:flutter_shopping_list/ui/profile_screen/profile_screen.dart';
import 'package:flutter_shopping_list/ui/register_screen/register_screen.dart';
import 'package:flutter_shopping_list/ui/services_scren/service_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
//https://stackoverflow.com/questions/72833245/calling-firebase-initializeapp-returns-unable-to-establish-connection-on-chan/72835948#72835948
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Firebase Riverpod',
      debugShowCheckedModeBanner: false,
      themeMode:ref.watch(ThemeModeProvider),
      theme: ThemeClass.light,
      darkTheme: ThemeClass.dark,
      routerConfig: AppRouter.router,
      //initialRoute:'/home' ,

/*      routes:{
        '/register':(context)=>registerScreen(),
        '/profile':(context)=>profileScreen(),
        '/services':(context)=>ListScreen_mobile_services(),
        '/details':(context)=>DetailsScreen(),
        '/login':(context)=> LoginScreen(),
        '/home':(context)=>HomeScreen(),
        '/admin':(context)=>adminScreen(),


        //'/navbar':(context)=>NavBar()
       } ,*/
    );
  }
}