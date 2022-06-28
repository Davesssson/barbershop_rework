
import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      accentColor: Colors.pink,
      scaffoldBackgroundColor: Colors.grey.shade900
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    accentColor: Colors.pink,
    scaffoldBackgroundColor: Colors.white
  );
}