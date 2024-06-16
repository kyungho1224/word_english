import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:word_english/database/database_helper.dart';
import 'package:word_english/provider/chapter_list_provider.dart';
import 'package:word_english/provider/package_info_provider.dart';
import 'package:word_english/provider/study_setting_provider.dart';
import 'package:word_english/provider/user_provider.dart';
import 'package:word_english/util/local_json.dart';
import 'package:word_english/word_english_app.dart';

import 'model/chapter_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  final dbHelper = DatabaseHelper.instance;
  bool validationTable = await dbHelper.validTables();
  if (!validationTable) {
    final list = await LocalJson.getObjectList<ChapterItem>("json/data.json");
    await dbHelper.insertDataIntoDatabase(list);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PackageInfoProvider()),
        ChangeNotifierProvider(create: (_) => StudySettingProvider()),
        ChangeNotifierProvider(create: (_) => ChapterListProvider()),
      ],
      child: const WordEnglishApp(),
    ),
  );
}
