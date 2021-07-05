class StoryFields {
  static final String id = '_id';
  static final String storyID = 'storyID';
  static final String author = 'author';
  static final String cover = 'cover';
  static final String full = 'full';
  static final String title = 'title';
  static final String chapter_count = 'chapter_count';
  static final String current_chapter_number = 'currentChapterNumber';
}

class StoryModel {
  final int? id;
  final String storyID;
  final String author;
  final String cover;
  final int full; // 1  ~ true , 0 ~ false
  final String title;
  final int chapter_count;
  final int currentChapterNumber;

  StoryModel({
    this.id,
    required this.storyID,
    required this.author,
    required this.cover,
    required this.full,
    required this.title,
    required this.chapter_count,
    required this.currentChapterNumber,
  });

  Map<String, Object?> toJson() => {
        StoryFields.id: id,
        StoryFields.storyID: storyID,
        StoryFields.author: author,
        StoryFields.cover: cover,
        StoryFields.full: full,
        StoryFields.title: title,
        StoryFields.chapter_count: chapter_count,
        StoryFields.current_chapter_number: currentChapterNumber,
      };

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
      storyID: json["storyID"],
      author: json["author"],
      cover: json["cover"],
      full: json["full"],
      title: json["title"],
      chapter_count: json["chapter_count"],
      currentChapterNumber: json["current_chapter_number"] ?? 1);

  Map<String, dynamic> toMap() => {
        "_id": id,
        "storyID": storyID,
        "author": author,
        "cover": cover,
        "full": full,
        "title": title,
        "chapter_count": chapter_count,
        "currentChapterNumber": currentChapterNumber
      };
}
