import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchScreenService {
  Future getData({required String keyword, required int offset, required int limit}) async {
    print("offest $offset");
    http.Response response = await http.get(Uri.parse(
        // \"Tru%20ti%C3%AAn\"
        "http://api.noveltyt.net/api/v2/stories/list?keyword=$keyword&limit=$limit&offset=$offset"));

    print(
        "http://api.noveltyt.net/api/v2/stories/list?keyword=$keyword&limit=$limit&offset=$offset");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"];
    } else {
      print("statuscode ${response.statusCode}");
      throw new Exception("error when call getData in search screen service");
    }
  }

  Future getFilterData(
      {required int offset,
        required int limit,
      required int full,
      required int maxChapter,
      required int minChapter,
      required String sortType,
      required List<String> genres}) async {
    var listToString = "";
    String apiURL = "";

    if (full == 2) {
      if (genres.isEmpty) {
        apiURL =
            "http://api.noveltyt.net/api/v2/stories/filter?limit=$limit&max_chapter_count=$maxChapter&min_chapter_count=$minChapter&offset=$offset&sort=$sortType";
      } else {
        listToString = convertListToString(genres);
        apiURL =
            "http://api.noveltyt.net/api/v2/stories/filter?genre=$listToString&limit=$limit&max_chapter_count=$maxChapter&min_chapter_count=$minChapter&offset=$offset&sort=$sortType";
      }
    } else {
      print(genres.isEmpty);
      if (genres.isEmpty) {
        apiURL =
            "http://api.noveltyt.net/api/v2/stories/filter?limit=$limit&max_chapter_count=$maxChapter&min_chapter_count=$minChapter&offset=$offset&sort=$sortType&full=$full";
      } else {
        listToString = convertListToString(genres);
        apiURL =
            "http://api.noveltyt.net/api/v2/stories/filter?genre=$listToString&limit=$limit&max_chapter_count=$maxChapter&min_chapter_count=$minChapter&offset=$offset&sort=$sortType&full=$full";
      }
    }

    // print(apiURL);

    http.Response response = await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"];
    } else {
      print("status code ${response.statusCode}");
      throw new Exception(
          "error when call getFilterData in search screen service");
    }
  }

  String convertListToString(List listToConvert) {
    var result = "";
    for (int i = 0; i < listToConvert.length; i++) {
      result = result + listToConvert[i];
      if (i != listToConvert.length - 1) {
        result = result + ",";
      }
    }

    return result;
  }
}
