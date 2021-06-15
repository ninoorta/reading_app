import 'package:flutter/material.dart';
import 'package:reading_app/screens/category/category_detail_screen.dart';
import 'package:reading_app/screens/category/category_screen.dart';
import 'package:reading_app/screens/history/history_screen.dart';
import 'package:reading_app/screens/main_screen.dart';
import 'package:reading_app/screens/search/filter_screen.dart';
import 'package:reading_app/screens/search/search_screen.dart';

import 'screens/explore/explore_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: "/",
      routes: {
        "/": (context) => MainScreen(),
        "/explore": (context) => ExploreScreen(),
        "/search": (context) => SearchScreen(),
        "/history": (context) => HistoryScreen(),
        "/filter": (context) => FilterScreen(),
        "/category": (context) => CategoryScreen(
              fromOtherRoute: false,
            ),
        "/categoryDetail": (context) => CategoryDetailScreen()
      },
    );
  }
}
