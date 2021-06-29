import 'package:path/path.dart';
import 'package:reading_app/models/story.dart';
import 'package:sqflite/sqflite.dart';

class StoryDatabase {
  static Database? _database;

  Future<Database> createDatabase() async {
    if (_database != null) return _database!;

    String dbPath = await getDatabasesPath();
    _database = await openDatabase(join(dbPath, "stories_database11.db"),
        onCreate: _createDB, version: 1);
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE Stories(
    ${StoryFields.id} $idType,
    ${StoryFields.storyID} $textType UNIQUE,
    ${StoryFields.author} $textType,
    ${StoryFields.cover} $textType,
    ${StoryFields.full} $boolType,
    ${StoryFields.title} $textType,
    ${StoryFields.chapter_count} $integerType,
    ${StoryFields.current_chapter_number} $integerType
    )
    
    ''');
  }

  Future<void> insertStory(StoryModel story) async {
    final Database db = await createDatabase();
    final storyModel = StoryModel(
      storyID: story.storyID,
      author: story.author,
      cover: story.cover,
      full: story.full,
      title: story.title,
      chapter_count: story.chapter_count,
      currentChapterNumber: story.currentChapterNumber,
    );

    await db.insert("Stories", storyModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // later read
  // Future<List<StoryModel>> getData() async {
  //   final Database  db = await createDatabase();
  //   final List<Map<String, Object?>> result = await db.query("Stories");
  //   return result.map((e) => StoryModel.fromJson(e)).toList();
  // }

  Future getData() async {
    final Database db = await createDatabase();
    final List<Map<String, Object?>> result = await db.query("Stories");
    return result;
  }

  Future deleteAll() async {}

// Future close() async {
//   final db = await instance.database;
//
//   db.close();
// }
}
