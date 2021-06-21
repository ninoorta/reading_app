import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// services
import 'package:reading_app/services/story_detail_screen_service.dart';

import 'menu_chapters_screen.dart';

class ReadingScreen extends StatefulWidget {
  ReadingScreen(
      {Key? key,
      required this.storyTitle,
      required this.storyID,
      required this.chapterCount,
      required this.currentChapter})
      : super(key: key);

  final String storyID;
  final String storyTitle;
  final int chapterCount;
  final int currentChapter;

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  bool visible = false;
  bool isLoading = true;
  Map storyData = {};

  String chapterTitle = "";
  String chapterContent = "";
  int currentChapterNumber = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    visible = true;
    currentChapterNumber = widget.currentChapter;
    getData();
  }

  void getData() async {
    isLoading = true;
    storyData = await StoryDetailScreenService(
            storyID: widget.storyID, chapterNumber: currentChapterNumber)
        .getData();

    setState(() {
      visible = false;
      isLoading = false;

      chapterTitle = storyData["title"];
      chapterContent = storyData["content"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: visible
            ? AppBar(
                backgroundColor: Colors.white,
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    new TextSpan(
                        text: chapterTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.blue,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        print("user clicks to refresh");
                        setState(() {
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.blue,
                      ))
                ],
              )
            : null,
        backgroundColor: Colors.white,
        persistentFooterButtons: visible
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("user wants to go back");
                        setState(() {
                          currentChapterNumber--;
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: currentChapterNumber == 1
                            ? Colors.grey[300]
                            : Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pushNewScreen(context,
                            screen: MenuChapters(
                                storyTitle: widget.storyTitle,
                                storyID: widget.storyID,
                                chaptersCount: widget.chapterCount),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino);
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print("user wants to read next");
                        setState(() {
                          currentChapterNumber++;
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: currentChapterNumber == widget.chapterCount
                            ? Colors.grey[300]
                            : Colors.blue,
                      ),
                    ),
                  ],
                )
              ]
            : null,
        body: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Đang tải...",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    print("show/hide navbar");
                    this.visible = !this.visible;
                  });
                },
                child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: visible ? 0 : 56,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              chapterTitle,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Html(data: chapterContent, style: {
                            "body": Style(
                                color: Colors.black,
                                fontSize: FontSize.rem(1.15))
                          }),
                          Container(
                            margin: EdgeInsets.only(bottom: 50, top: 20),
                            child: Center(
                              child: Text(
                                "--- $currentChapterNumber "
                                "/ ${widget.chapterCount} ---",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
