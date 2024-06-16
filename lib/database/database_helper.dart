import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_english/model/chapter_item_model.dart';
import 'package:word_english/model/part_item_model.dart';
import 'package:word_english/model/study_item_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const _databaseName = "word_english.db";
  static const _databaseVersion = 1;

  // Table and column names
  static const tableChapter = 'chapter';
  static const tablePart = 'part';
  static const tableStudyItem = 'study_item';

  // Chapter columns
  static const columnChapterId = 'chapter_id';
  static const columnChapterLastModifiedDate = 'last_modified_date';
  static const columnChapterTotalCount = 'total_count';

  // Part columns
  static const columnPartId = 'part_id';

  // StudyItem columns
  static const columnStudyId = 'study_id';
  static const columnEWord = 'e_word';
  static const columnKWord = 'k_word';
  static const columnESentence = 'e_sentence';
  static const columnKSentence = 'k_sentence';
  static const columnBookmark = 'bookmark';
  static const columnViewer = 'viewer';

  // Singleton instance
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    String path = join(_databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableChapter (
        id INTEGER PRIMARY KEY,
        $columnChapterId INTEGER,
        $columnChapterTotalCount INTEGER,
        $columnChapterLastModifiedDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablePart (
        id INTEGER PRIMARY KEY,
        $columnPartId INTEGER,
        $columnChapterId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableStudyItem (
        id INTEGER PRIMARY KEY,
        $columnStudyId INTEGER,
        $columnEWord TEXT,
        $columnKWord TEXT,
        $columnESentence TEXT,
        $columnKSentence TEXT,
        $columnBookmark INTEGER,
        $columnViewer INTEGER,
        $columnPartId INTEGER,
        $columnChapterId INTEGER
      )
    ''');
  }

  /* 최초 실행(json 파싱 데이터 -> sql) */
  Future<void> insertDataIntoDatabase(List<ChapterItem> chapters) async {
    Database db = await instance.database;
    try {
      for (ChapterItem chapter in chapters) {
        await db.transaction((transactional) async {
          await transactional.rawInsert('''
            INSERT INTO $tableChapter ($columnChapterId, $columnChapterTotalCount, 
            $columnChapterLastModifiedDate) VALUES (?, ?, ?)
          ''', [chapter.chapter, 400, null]);
        });
        for (PartItem part in chapter.partItemList) {
          await db.transaction((transactional) async {
            await transactional.rawInsert('''
            INSERT INTO $tablePart ($columnPartId, $columnChapterId) VALUES (?, ?)
          ''', [part.partId, chapter.chapter]);
          });
          for (StudyItem item in part.studyItemList) {
            await db.transaction((transactional) async {
              await transactional.rawInsert('''
            INSERT INTO $tableStudyItem ($columnStudyId, $columnEWord, 
            $columnKWord, $columnESentence, $columnKSentence, 
            $columnBookmark, $columnViewer, 
            $columnPartId, $columnChapterId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
          ''', [
                item.id,
                item.eWord.replaceAll("'", "''"),
                item.kWord.replaceAll("'", "''"),
                item.eSentence.replaceAll("'", "''"),
                item.kSentence.replaceAll("'", "''"),
                item.bookmark ? 1 : 0,
                item.viewer ? 1 : 0,
                part.partId,
                chapter.chapter,
              ]);
            });
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<ChapterItem>> getAllChapters() async {
    Database db = await instance.database;
    var result = await db.query(tableChapter);

    List<ChapterItem> chapters = [];
    for (var chapter in result) {
      int chapterId = chapter['chapter_id'] as int;
      int totalCount = chapter[columnChapterTotalCount] as int;
      List<PartItem> parts = await getPartsByChapterId(chapterId);
      chapters.add(ChapterItem(
        chapter: chapterId,
        partItemList: parts,
        totalCount: totalCount,
        lastModifiedDate: chapter['last_modified_date'] != null
            ? DateTime.parse(chapter[columnChapterLastModifiedDate] as String)
            : null,
      ));
    }
    return chapters;
  }

  Future<void> updateChapterLastModifiedDate(int chapterId) async {
    String currentTime = DateTime.now().toIso8601String();
    Database db = await instance.database;
    int result = await db.update(
      tableChapter,
      {columnChapterLastModifiedDate: currentTime},
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
    );
  }

  Future<List<PartItem>> getPartsByChapterId(int chapterId) async {
    Database db = await instance.database;
    var result = await db
        .query(tablePart, where: 'chapter_id = ?', whereArgs: [chapterId]);

    List<PartItem> parts = [];
    for (var part in result) {
      int partId = part['part_id'] as int;
      List<StudyItem> studies = await getStudyItemsByPartId(chapterId, partId);
      parts.add(PartItem(partId: partId, studyItemList: studies));
    }
    return parts;
  }

  Future<List<StudyItem>> getStudyItemsByPartId(
      int chapterId, int partId) async {
    Database db = await instance.database;
    var result = await db.query(tableStudyItem,
        where: 'chapter_id = ? AND part_id = ?',
        whereArgs: [chapterId, partId]);

    List<StudyItem> studyList = [];
    for (var item in result) {
      studyList.add(
        StudyItem(
          id: item['id'] as int,
          eWord: item['e_word'] as String,
          kWord: item['k_word'] as String,
          eSentence: item['e_sentence'] as String,
          kSentence: item['k_sentence'] as String,
          bookmark: (item['bookmark'] as int) == 1,
          viewer: (item['viewer'] as int) == 1,
        ),
      );
    }
    return studyList;
  }

  Future<StudyItem> getStudyItemsId(int id) async {
    Database db = await instance.database;
    var result =
        await db.query(tableStudyItem, where: 'id = ?', whereArgs: [id]);

    return StudyItem(
      id: result.first[columnStudyId] as int,
      eWord: result.first['e_word'] as String,
      kWord: result.first['k_word'] as String,
      eSentence: result.first['e_sentence'] as String,
      kSentence: result.first['k_sentence'] as String,
      bookmark: (result.first['bookmark'] as int) == 1,
      viewer: (result.first['viewer'] as int) == 1,
    );
  }

  Future<void> progressWord(int chapterId, int partId, int studyId) async {
    Database db = await instance.database;
    await db.update(
      tableStudyItem,
      {columnViewer: 1},
      where: 'chapter_id = ? AND part_id = ? AND study_id = ?',
      whereArgs: [chapterId, partId, studyId],
    );
  }

  Future<void> updateBookmark(int id) async {
    Database db = await instance.database;
    var result = await db.query(
      tableStudyItem,
      where: 'id = ?',
      whereArgs: [id],
    );

    int currentBookmark = result.first[columnBookmark] as int;
    int newBookmark = currentBookmark == 1 ? 0 : 1;
    print('currentBookmark: $currentBookmark, newBookmark: $newBookmark');
    await db.update(
      tableStudyItem,
      {columnBookmark: newBookmark},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /* validation method */
  /* 현재 테이블 목록 조회 */
  Future<List<String>> getTableList() async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
    List<String> tableNames =
        result.map((row) => row['name'] as String).toList();
    return tableNames;
  }

  /* 특정 테이블 존재 유무 */
  Future<bool> _isTableExists(String tableName) async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

  /* 필요한 테이블 모두 존재 하는지 */
  Future<bool> validTables() async {
    return await existRecordAtTable(tableChapter) &&
        await existRecordAtTable(tablePart) &&
        await existRecordAtTable(tableStudyItem);
  }

  /* 특정 테이블 레코드 카운트 */
  Future<bool> existRecordAtTable(String tableName) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count > 0;
  }

  Future<void> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    await deleteDatabase(path);

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // 여기에 테이블 생성 로직 작성
    });

    await database.close();
  }
}
