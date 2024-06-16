import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/model/part_item_model.dart';

import '../database/database_helper.dart';
import '../model/chapter_item_model.dart';

class ChapterListProvider with ChangeNotifier {
  ChapterListProvider() {
    fetchChapters();
  }

  List<ChapterItem> _chapterList = [];
  bool _bookmarked = false;

  List<ChapterItem> get chapterList => _chapterList;
  bool get bookmarked => _bookmarked;

  void setChapterList(List<ChapterItem> chapters) {
    _chapterList = chapters;
    notifyListeners();
  }

  Future<void> fetchChapters() async {
    final dbHelper = DatabaseHelper.instance;
    final list = await dbHelper.getAllChapters();
    setChapterList(list);
  }

  Future<void> updateChapterLastModifiedDate(int chapterId) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updateChapterLastModifiedDate(chapterId);
    await fetchChapters();
  }

  Future<void> updateProgressWord(
      int chapterId, int partId, int studyId) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.progressWord(chapterId, partId, studyId);
    await fetchChapters();
  }

  int progressCounterByPartId(int chapterIndex, int partIndex) {
    return _chapterList[chapterIndex]
        .partItemList[partIndex]
        .studyItemList
        .where((item) => item.viewer == true)
        .count();
  }

  int progressCounterByChapterId(int chapterIndex) {
    int totalCount = 0;
    for (var part in _chapterList[chapterIndex].partItemList) {
      totalCount +=
          part.studyItemList.where((item) => item.viewer == true).count();
    }
    return totalCount;
  }

  List<ChapterItem> getBookmarkWordList() {
    List<ChapterItem> bookmarkChapters = [];
    for (var chapterItem in _chapterList) {
      List<PartItem> bookmarkParts = [];
      for (var partItem in chapterItem.partItemList) {
        var studyBookmarks = partItem.studyItemList.where((studyItem) {
          return studyItem.bookmark == true;
        }).toList();
        if (studyBookmarks.isNotEmpty) {
          bookmarkParts.add(
              PartItem(partId: partItem.partId, studyItemList: studyBookmarks));
        }
      }
      if (bookmarkParts.isNotEmpty) {
        bookmarkChapters.add(ChapterItem(
            chapter: chapterItem.chapter, partItemList: bookmarkParts));
      }
    }
    return bookmarkChapters;
  }

  Future<void> getBookmarkState(int id) async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.getStudyItemsId(id);
    _bookmarked = result.bookmark;
    notifyListeners();
  }

  Future<void> updateBookmark(int id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updateBookmark(id);
    await getBookmarkState(id);
    fetchChapters();
  }

  Future<void> refreshChapters() async {
    final dbHelper = DatabaseHelper.instance;
    final list = await dbHelper.getAllChapters();
    setChapterList(list);
  }

  Future<List<ChapterItem>> getBookmarkWordListWithRefresh() async {
    await refreshChapters();
    return getBookmarkWordList();
  }

  Future<void> deleteProgressByChapterId(int chapterId) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updateLastModifiedDateAndResetViewer(chapterId);
    await fetchChapters();
    notifyListeners();
  }

}
