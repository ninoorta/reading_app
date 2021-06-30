import 'package:path/path.dart';
import 'package:reading_app/models/story.dart';
import 'package:sqflite/sqflite.dart';

class StoryDatabase {
  Database? _database;

  Future<Database> createDatabase() async {
    if (_database != null) return _database!;

    String dbPath = await getDatabasesPath();
    _database = await openDatabase(join(dbPath, "stories_database99.db"),
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

    // await batch.commit(noResult: true);
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
    var test = {
      "storyID": "testStoryID",
      "author": "testName",
      "cover": "testCover",
      "full": "1",
      "title": "testTitle",
      "chapter_count": 55,
      "currentChapterNumber": 20
    };
    var test2 = {
      "storyID": "testStoryID2",
      "author": "\t\e\st\"\N\a\m\e\2",
      "cover": "testCover2",
      "full": "1",
      "title": "testTitle2",
      "chapter_count": 552,
      "currentChapterNumber": 202
    };
    // db.insert("Stories", test1, test2);
    // var test3 = await db.rawInsert(
    //     "INSERT INTO Stories(storyID, author, cover, full, title, chapter_count, currentChapterNumber) "
    //     "VALUES ('testStoryID', 'testName', 'testCover', 1, 'testTitle', 55, 20),"
    //     " ('testStoryID2', 'testName', 'testCover', 1, 'testTitle', 55, 20);"
    //     "");

    // debugPrint(test3.toString()); // print the id of last item;

    // db.transaction((txn) async {
    //   int newID = await txn.insert("Stories", storyModel.toMap(),
    //       conflictAlgorithm: ConflictAlgorithm.replace);
    //   print("done with new item $newID");
    // });
    var batch = db.batch();
    batch.insert("Stories", storyModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    await batch.commit(noResult: true);
    // await db.insert("Stories", storyModel.toMap(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // later read
  // Future<List<StoryModel>> getData() async {
  //   final Database  db = await createDatabase();
  //   final List<Map<String, Object?>> result = await db.query("Stories");
  //   return result.map((e) => StoryModel.fromJson(e)).toList();
  // }

  Future getData() async {
    final Database db = await createDatabase();
    var batch = db.batch();
    // List<Map<String, Object?>> result = [];
    // batch.query("Stories");
    // // db.transaction((txn) async {
    // //   result = await txn.query("Stories");
    // // });
    // await batch.commit(noResult: true);
    // print("result getData $result");
    final List<Map<String, Object?>> result = await db.query("Stories");
    // batch.query("Stories");
    // List result = await batch.commit();
    // var finalResult;
    // db.transaction((txn) async {
    //   final List<Map<String, Object?>> result = await txn.query("Stories");
    //   finalResult = result;
    // });
    return result;
  }

  Future findWithStoryID(String storyID) async {
    final Database db = await createDatabase();
    var result =
        await db.query("Stories", where: 'storyID = ?', whereArgs: [storyID]);
    // print("result find : $result");
    return result;
  }

  Future deleteAll() async {
    final Database db = await createDatabase();
    await db.rawDelete(""
        "DELETE FROM Stories"
        "");
  }

  Future close() async {
    final Database db = await createDatabase();
    await db.close();
  }
}
