
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.grey.shade900,
      primarySwatch: Colors.grey,
      accentColor: Colors.pink,
      scaffoldBackgroundColor: Colors.grey.shade400
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    primaryColor: Colors.brown.shade900,
    accentColor: Colors.pink,
    scaffoldBackgroundColor: Colors.brown
  );
}