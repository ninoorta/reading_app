import 'dart:convert';

import 'package:http/http.dart' as http;

var apiURL = "http://api.truyenyeuthich.com/api/v2/features";

class ExploreScreenService {
  // final String apiURL;
  //
  // ExploreScreenService({required this.apiURL});

  Future getData() async {
    http.Response response = await http.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print("hello it's data : $data");
      return data["data"];
    } else {
      print("status code: ${response.statusCode}");
      throw Exception("err when getData in explore screen");
    }
  }

  Future getGroupData(
      {required String groupID, required int groupOffset}) async {
    http.Response response = await http.get(Uri.parse(
        "http://api.noveltyt.net/api/v2/stories/group?id=$groupID&limit=50&offset=$groupOffset"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"];
    } else {
      print("status code: ${response.statusCode}");
      throw Exception("err when getGroupData in explore screen");
    }
  }

  Future getListDetailData(
      {required int offset, required String sortType, required int limit}) async {
    http.Response response = await http.get(Uri.parse(
        "http://api.noveltyt.net/api/v2/stories/list?limit=$limit&offset=$offset&sort=$sortType"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["data"];
    } else {
      print("status code: ${response.statusCode}");
      throw Exception("err when getListDetailData in explore screen");
    }
  }
}
