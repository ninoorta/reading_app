// import 'dart:convert';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class StoryPreferences {
//   static SharedPreferences? _sharedPreferences;
//
//   // key ;
//   static const _keyStories = 'superStoryKey';
//
//   static Future init() async =>
//       _sharedPreferences = await SharedPreferences.getInstance();
//
//   static Future setStory(
//       {required Map storyData, required String storyID}) async {
//     final String jsonData = jsonEncode(storyData);
//     final id = storyID;
//
//     await _sharedPreferences!.setString(id, jsonData);
//   }
//
//   static Map getStory(String storyID) {
//     print("getStory $storyID");
//     try {
//       final String? jsonData = _sharedPreferences!.getString(storyID);
//       return jsonDecode(jsonData!);
//     } catch (err) {
//       throw new Exception(err);
//     }
//   }
//
//   static Future addStory({required String storyID}) async {
//     final storyIDList =
//         _sharedPreferences!.getStringList(_keyStories) ?? <String>[];
//     final newStoryIDList = List.of(storyIDList)..add(storyID);
//
//     await _sharedPreferences!.setStringList(_keyStories, newStoryIDList);
//   }
//
//   static List getStories() {
//     final storyIDList = _sharedPreferences!.getStringList(_keyStories);
//
//     if (storyIDList == null) {
//       return [];
//     } else {
//       return storyIDList.map(getStory).toList();
//     }
//   }
// }
