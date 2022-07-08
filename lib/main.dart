import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/constants/theme_data.dart';
import 'package:flutter_shopping_list/controllers/theme_controller.dart';
import 'package:flutter_shopping_list/ui/details_screen/details_screen.dart';
import 'package:flutter_shopping_list/ui/home_screen.dart';
import 'package:flutter_shopping_list/ui/login_screen/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';

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
    return MaterialApp(
      title: 'Flutter Firebase Riverpod',
      debugShowCheckedModeBanner: false,
      themeMode:ref.watch(ThemeModeProvider),
      theme: ThemeClass.light,
      darkTheme: ThemeClass.dark,
      initialRoute:'/login' ,
      routes:{
        '/details':(context)=>DetailsScreen(),
        '/login':(context)=> LoginScreen(),
        '/home':(context)=>HomeScreen(),
        //'/navbar':(context)=>NavBar()
       } ,
    );
  }
}