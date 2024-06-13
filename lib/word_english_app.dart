import 'package:flutter/material.dart';
import 'package:word_english/common/theme/custom_theme.dart';
import 'package:word_english/screen/s_main.dart';

class WordEnglishApp extends StatefulWidget {
  const WordEnglishApp({super.key});

  @override
  State<WordEnglishApp> createState() => _WordEnglishAppState();
}

class _WordEnglishAppState extends State<WordEnglishApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MainScreen(),
    );
  }
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  colorScheme:
      ColorScheme.fromSeed(seedColor: CustomTheme.light.appColors.seedColor),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
      seedColor: CustomTheme.dark.appColors.seedColor,
      brightness: Brightness.dark),
);
