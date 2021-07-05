import 'dart:convert';

import 'package:http/http.dart' as http;

class StoryDetailScreenService {
  final String storyID;
  int chapterNumber;

  StoryDetailScreenService(
      {required this.storyID, required this.chapterNumber});

  Future getChapterData() async {
    http.Response response = await http.get(Uri.parse(
        "http://api.noveltyt.net/api/v2/chapters/detail?number=$chapterNumber&story_id=${this.storyID}"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"];
    } else {
      print("status code ${response.statusCode}");
      throw Exception("error in story detail screen service");
    }
  }
}
