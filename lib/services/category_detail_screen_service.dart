import 'dart:convert';

import 'package:http/http.dart' as http;

class CategoryDetailScreenService {
  Future getData({
    required String genre,
    required int offset,
    required String sortType,
    required int limitItem,
  }) async {
    http.Response response = await http.get(Uri.parse(
        "http://api.noveltyt.net/api/v2/stories/list?genre=$genre&offset=$offset&sort=$sortType&full=1&limit=$limitItem"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"];
    } else {
      print("status code: ${response.statusCode}");
      throw Exception("error in category detail screen service");
    }
  }
}
