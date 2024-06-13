import 'package:flutter/material.dart';
import 'package:word_english/common/theme/color/dark_app_colors.dart';
import 'package:word_english/common/theme/color/light_app_colors.dart';

import 'color/abs_theme_colors.dart';

enum CustomTheme {
  dark(DarkAppColors()),
  light(LightAppColors());

  final AbstractThemeColors appColors;

  const CustomTheme(this.appColors);

  ThemeData get themeData {
    switch (this) {
      case CustomTheme.dark:
        return darkTheme;
      case CustomTheme.light:
        return lightTheme;
    }
  }
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  colorScheme:
      ColorScheme.fromSeed(seedColor: CustomTheme.light.appColors.seedColor),
);

const darkColorSeed = Color(0xbcd5ff7e);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
      seedColor: CustomTheme.dark.appColors.seedColor,
      brightness: Brightness.dark),
);
