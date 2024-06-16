import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class StudySettingProvider with ChangeNotifier {
  bool _visible = false;
  bool _bookmarked = false;

  bool get visible => _visible;

  bool get bookmarked => _bookmarked;

  void toggle() {
    _visible = !_visible;
    notifyListeners();
  }

  // Future<void> getBookmarkState(int id) async {
  //   final dbHelper = DatabaseHelper.instance;
  //   final result = await dbHelper.getStudyItemsId(id);
  //   _bookmarked = result.bookmark;
  //   notifyListeners();
  // }
  //
  // Future<void> updateBookmark(int id) async {
  //   final dbHelper = DatabaseHelper.instance;
  //   await dbHelper.updateBookmark(id);
  //   await getBookmarkState(id);
  // }
}
