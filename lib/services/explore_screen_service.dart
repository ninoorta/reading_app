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
      throw Exception("err when getData in explore screen");
    }
  }
}
