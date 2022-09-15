
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blueGrey,
      primaryColor: Color.fromRGBO(207, 216, 220,1),
      secondaryHeaderColor: Color.fromRGBO(117, 117 , 117, 1),
      scaffoldBackgroundColor: Colors.blueGrey.shade300,
      errorColor: Color.fromRGBO(176, 0,32, 1),


  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColor: Color.fromRGBO(69, 90,100,1),
    secondaryHeaderColor: Color.fromRGBO(117, 117 , 117, 1),
    scaffoldBackgroundColor: Colors.grey.shade600,
    errorColor: Color.fromRGBO(176, 0,32, 1),
  );
}