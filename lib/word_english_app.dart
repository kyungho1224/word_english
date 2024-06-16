import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:provider/provider.dart';
import 'package:word_english/common/theme/custom_theme.dart';
import 'package:word_english/provider/user_provider.dart';
import 'package:word_english/screen/s_bookmark.dart';
import 'package:word_english/screen/s_login.dart';
import 'package:word_english/screen/s_main.dart';
import 'package:word_english/screen/s_part.dart';
import 'package:word_english/screen/s_study.dart';

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
      // home: const AuthCheck(),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthCheck(),
        '/bookmark': (context) => const BookmarkScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/part') {
          final args = settings.arguments as Map<String, int>;
          return MaterialPageRoute(
            builder: (context) => PartScreen(
              chapterIndex: args['chapterIndex']!,
              chapterId: args['chapterId']!,
            ),
          );
        } else if (settings.name == '/study') {
          final args = settings.arguments as Map<String, int>;
          return MaterialPageRoute(
            builder: (context) => StudyScreen(
              chapterIndex: args['chapterIndex']!,
              chapterId: args['chapterId']!,
              partIndex: args['partIndex']!,
              partId: args['partId']!,
            ),
          );
        }
        return null;
      },
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

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.user == null ? const LoginScreen() : const MainScreen();
  }
}
