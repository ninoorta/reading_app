import 'dart:convert';

import 'package:http/http.dart' as http;

var apiURL = "http://api.noveltyt.net/api/v2/stories?id=";

class StoreInfoScreenService {
  final String storeID;

  StoreInfoScreenService({required this.storeID});

  Future getData() async {
    http.Response response = await http
        .get(Uri.parse("http://api.noveltyt.net/api/v2/stories?id=$storeID"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print("hello it's data : $data");
      return data["data"];
    } else {
      print("apiURL $apiURL");
      print("status code: ${response.statusCode}");
      throw Exception("err when getData in getData in story info screen");
    }
  }

  Future getChaptersData(
      {required int startOffset, required int endOffset}) async {
    print("startOffset $startOffset, endOffset $endOffset");
    http.Response response = await http.get(Uri.parse(
        "http://api.noveltyt.net/api/v2/chapters/numbers?end=$endOffset&start=$startOffset&story_id=$storeID"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print("hello it's data : $data");
      return data["data"];
    } else {
      print("apiURL $apiURL");
      print("status code: ${response.statusCode}");
      throw Exception(
          "err when getData in getChaptersData in story info screen");
    }
  }
}
