import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_english/provider/package_info_provider.dart';
import 'package:word_english/provider/study_item_provider.dart';
import 'package:word_english/word_english_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PackageInfoProvider()),
        ChangeNotifierProvider(create: (_) => StudyItemProvider()),
      ],
      child: const WordEnglishApp(),
    ),
  );
}
