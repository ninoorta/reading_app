import 'package:flutter/material.dart';
import 'package:reading_app/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Truyện Gemmob",
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("Mới đăng", style: kListTitleTextStyle),
                TextButton(
                    onPressed: () {
                      print("click see more");
                    },
                    child: Text(
                      "Xem thêm",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ))
              ],
            ),
            Container(
              height: 150.0,
              width: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                      ),
                      Container(
                        child: AutoSizeText(
                          "This text is so longgggggggggggggggggggggggggggggggggggggggggggggggggggggggggg.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                          minFontSize: 14.0,
                        ),
                        height: 50,
                        width: 100,
                        padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
