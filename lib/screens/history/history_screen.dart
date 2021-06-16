import 'package:flutter/material.dart';

import '../../constants.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lịch Sử Đọc Truyện",
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(bottom: 10.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                BuildHistoryList(
                  title: "Đọc Gần Đây",
                ),
                BuildHistoryList(
                  title: "Yêu Thích Gần Đây",
                ),
                BuildHistoryList(
                  title: "Tải Gần Đây",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildHistoryList extends StatelessWidget {
  const BuildHistoryList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                print("user click to see more");
              },
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 20,
            )
          ],
        ),
        Container(
          // height: 600,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.5,
              crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0
            ),
            itemBuilder: (context, index) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0)),
                    // width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      new TextSpan(
                          text:
                              "This is the title of the story but it seems to be so longgggggggggggggggggggggggggg",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      new TextSpan(
                          text:
                              "This is the title of the story but it seems to be so longgggggggggggggggggggggggggg",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      new TextSpan(
                          text:
                              "This is the title of the story but it seems to be so longgggggggggggggggggggggggggg",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ]),
                  )
                ],
              );
            },
          ),
        ),
        // ListView.builder(
        //   itemCount: 4,
        //
        //
        // )
      ],
    );
  }
}
