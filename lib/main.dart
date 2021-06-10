import 'package:flutter/material.dart';
import 'package:reading_app/screens/category_detail_screen.dart';
import 'package:reading_app/screens/category_screen.dart';
import 'package:reading_app/screens/filter_screen.dart';
import 'package:reading_app/screens/history_screen.dart';
import 'package:reading_app/screens/main_screen.dart';
import 'package:reading_app/screens/search_screen.dart';
import 'screens/explore_screen.dart';

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
        "/category": (context) => CategoryScreen(),
        "/categoryDetail": (context) => CategoryDetailScreen()
      },
    );
  }
}
