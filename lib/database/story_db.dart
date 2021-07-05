import 'package:path/path.dart';
import 'package:reading_app/models/story.dart';
import 'package:sqflite/sqflite.dart';

class StoryDatabase {
  Database? _database;

  Future<Database> createDatabase() async {
    if (_database != null) return _database!;

    String dbPath = await getDatabasesPath();
    _database = await openDatabase(join(dbPath, "database_stories.db"),
        onCreate: _createDB, version: 1);
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // var batch = db.batch();

    db.execute('''
    CREATE TABLE RecentRead(
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
    db.execute('''
    CREATE TABLE Favorite(
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

    // await batch.commit(noResult: true);
  }

  Future<void> insertStory(
      {required String tableName, required StoryModel story}) async {
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
    var batch = db.batch();
    batch.insert("$tableName", storyModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    await batch.commit(noResult: true);
    // await db.insert("Stories", storyModel.toMap(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Future<void> insertFavoriteStory(
  //     {required String tableName, required StoryModel story}) async {
  //
  // }

  // later read
  // Future<List<StoryModel>> getData() async {
  //   final Database  db = await createDatabase();
  //   final List<Map<String, Object?>> result = await db.query("Stories");
  //   return result.map((e) => StoryModel.fromJson(e)).toList();
  // }

  Future getData({required String tableName}) async {
    final Database db = await createDatabase();
    final List<Map<String, Object?>> result = await db.query(tableName);
    return result;
  }

  Future findWithStoryID(
      {required String tableName, required String storyID}) async {
    final Database db = await createDatabase();
    var result = await db
        .query("$tableName", where: 'storyID = ?', whereArgs: [storyID]);
    // print("result find : $result");
    return result;
  }

  Future deleteAll({required String tableName}) async {
    final Database db = await createDatabase();
    await db.rawDelete(""
        "DELETE FROM $tableName"
        "");
  }

  Future deleteOne({required String tableName, required String storyID}) async {
    final Database db = await createDatabase();
    await db.rawDelete(""
        "DELETE FROM $tableName WHERE storyID = '$storyID';"
        "");
  }

  Future close() async {
    final Database db = await createDatabase();
    await db.close();
  }
}
