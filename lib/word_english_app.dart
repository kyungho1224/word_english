import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:word_english/common/theme/custom_theme.dart';
import 'package:word_english/screen/s_home.dart';

class WordEnglishApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const WordEnglishApp({super.key});

  @override
  State<WordEnglishApp> createState() => _WordEnglishAppState();
}

class _WordEnglishAppState extends State<WordEnglishApp> with Nav {
  @override
  GlobalKey<NavigatorState> get navigatorKey => WordEnglishApp.navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomeScreen(),
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
