
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
enum ThemeModeFilter {
  light,
  dark,
  system
}

final ThemeModeFilterProvider = StateProvider<ThemeModeFilter>((_) => ThemeModeFilter.dark);

final ThemeModeProvider = Provider<ThemeMode>((ref){
  developer.log("[theme_controller.dart][-][ThemeModeProvider] - ThemeModeProvider .");
  final themeModeFilterState = ref.watch(ThemeModeFilterProvider);
  switch(themeModeFilterState){
    case ThemeModeFilter.dark:
      return ThemeMode.dark;
    case ThemeModeFilter.light:
      return ThemeMode.light;
    case ThemeModeFilter.system:
      return ThemeMode.system;
    default:
      return ThemeMode.light;
  }
});


