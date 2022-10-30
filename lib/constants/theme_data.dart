
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      //primarySwatch: Colors.blueGrey,
      primaryColor: Colors.white,
      secondaryHeaderColor: Color.fromRGBO(117, 117 , 117, 1),
      scaffoldBackgroundColor: Colors.white,
      errorColor: Color.fromRGBO(176, 0,32, 1),
      cardColor: Color.fromRGBO(225, 225, 225, 1),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(color: Colors.black),
        headlineMedium: TextStyle(color: Colors.black),
        headlineSmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),


      )


  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColor: Color.fromRGBO(3, 218, 198, 1),
    //secondaryHeaderColor: Color.fromRGBO(117, 117 , 117, 1),
    scaffoldBackgroundColor: Color.fromRGBO(48, 48, 48, 1),
    errorColor: Color.fromRGBO(176, 0,32, 1),
    cardColor: Color.fromRGBO(42, 42, 42, 1),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),


    )
  );
}