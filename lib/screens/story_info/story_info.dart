import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/story_info/components/single_choice_chip_for_link.dart';
import 'package:reading_app/screens/story_info/download_screen.dart';
import 'package:reading_app/screens/story_info/menu_chapters_screen.dart';
import 'package:reading_app/screens/story_info/reading_screen.dart';
// services
import "package:reading_app/services/story_info_screen_service.dart";
import 'package:reading_app/utilities/time.dart';

class StoryInfo extends StatefulWidget {
  StoryInfo({Key? key, required this.storyID}) : super(key: key);
  String storyID = "";

  @override
  _StoryInfoState createState() => _StoryInfoState();
}

class _StoryInfoState extends State<StoryInfo> {
  //
  // List<String> testTypeList = [
  //   "Ngôn tình",
  //   "Xuyên không",
  //   "Cổ đại",
  //   "Ngôn tình2",
  //   "Xuyên không2",
  //   "Cổ đại2",
  // ];

  bool isLoading = true;

  Map storyData = {};

  String storyTitleAppbar = "";
  String storyTitle = "";
  String storyImageCoverURL = "";
  String storyAuthor = "";
  String storyStatus = "";
  String storyRecentPostTime = "";
  int storyChapters = 0;
  int storyFavoriteCount = 0;
  int storyViewedCount = 0;

  List storyGenres = [];

  String storySource = "";

  String storyDescription = "";

  ScrollController _scrollController = ScrollController();

  String testText = "";

  Map timeData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("storyID: ${widget.storyID}");
    getData();
  }

  void getData() async {
    storyData = await StoreInfoScreenService(storeID: widget.storyID).getData();

    timeData = Time().convertTimeToDHMS(
        startTime: storyData["created"], endTime: storyData["updated"]);

    setState(() {
      isLoading = false;

      if (timeData["days"] == 0) {
        storyRecentPostTime = "${timeData["hours"]} giờ trước";
        if (timeData["hours"] == 0) {
          storyRecentPostTime = "${timeData["minutes"]} phút trước";
          if (timeData["minutes"] == 0) {
            storyRecentPostTime = "Vừa mới đây";
          }
        }
      } else {
        storyRecentPostTime = "${timeData["days"]} ngày trước";
      }

      storyTitle = storyData["title"];
      storyAuthor = storyData["author"];
      storyStatus = storyData["full"] ? "FULL" : "Đang ra";

      storyChapters = storyData["chapter_count"];
      storyFavoriteCount = storyData["like_count"] ?? storyFavoriteCount;
      storyViewedCount = storyData["view_count"] ?? storyViewedCount;
      storyGenres = storyData["genre"];

      storyImageCoverURL = storyData["cover"];

      storySource = storyData["source"];
      storyDescription = storyData["desc"];
    });

    // debugPrint(storyData.toString(), wrapWidth: 1024);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
                text: storyTitleAppbar,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22))
          ]),
        ),
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  pushNewScreen(context,
                      screen: DownloadScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.file_download,
                      color: Colors.blue,
                      size: 25,
                    ),
                    Text(
                      "Tải về",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  print("user want to read this one");

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReadingScreen(
                        storyTitle: storyTitle,
                        storyID: widget.storyID,
                        chapterCount: storyChapters);
                  }));
                },
                child: Text(
                  "Đọc truyện",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                splashColor: Colors.lightBlueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
              RawMaterialButton(
                onPressed: () {
                  pushNewScreen(context,
                      screen: MenuChapters(
                        storyTitle: storyTitle,
                        storyID: widget.storyID,
                        chaptersCount: storyChapters,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino);
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.menu,
                      color: Colors.blue,
                      size: 25,
                    ),
                    Text(
                      "Mục lục",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
      body: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "Đang tải...",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ),
                )
              ],
            )
          : NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                // print(_scrollController.position.pixels);
                if (_scrollController.position.pixels > 35) {
                  setState(() {
                    storyTitleAppbar = storyTitle;
                  });
                } else if (_scrollController.position.pixels == 0 ||
                    _scrollController.position.pixels < 30) {
                  setState(() {
                    storyTitleAppbar = "";
                  });
                }
                return true;
              },
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: RichText(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    text: TextSpan(children: [
                                      new TextSpan(
                                          text: storyTitle,
                                          style: kTitleTextStyle)
                                    ])),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  RichText(
                                    text: new TextSpan(children: [
                                      new TextSpan(
                                          text: "Tác giả: ",
                                          style: kMediumDarkerTitleTextStyle),
                                      new TextSpan(
                                          text: storyAuthor,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              print("click author name");
                                            })
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  CustomRichText(
                                      title: "Tình trạng",
                                      titleValue: storyStatus),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  CustomRichText(
                                      title: "Đăng gần nhất",
                                      titleValue: storyRecentPostTime),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  CustomRichText(
                                      title: "Số chương",
                                      titleValue: storyChapters.toString()),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  CustomRichText(
                                      title: "Lượt yêu thích",
                                      titleValue:
                                          storyFavoriteCount.toString()),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  CustomRichText(
                                      title: "Số người đã đọc",
                                      titleValue: storyViewedCount.toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 50,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    imageUrl: storyImageCoverURL,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        SingleChoiceChipForLink(storyGenres),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(
                                  minWidth: 35.0, minHeight: 35.0),
                              onPressed: () {
                                print("user choose this as favorite one");
                              },
                              elevation: 1.0,
                              fillColor: Colors.white,
                              splashColor: Colors.lightBlue[200],
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.favorite_border,
                                size: 25.0,
                                color: Colors.blue,
                              ),
                              shape: CircleBorder(
                                  side: BorderSide(color: Colors.blue)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(
                                  minWidth: 35.0, minHeight: 35.0),
                              onPressed: () {
                                print(
                                    "user choose this to write some comments");
                              },
                              elevation: 1.0,
                              fillColor: Colors.white,
                              splashColor: Colors.lightBlue[200],
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.rate_review_outlined,
                                size: 25.0,
                                color: Colors.blue,
                              ),
                              shape: CircleBorder(
                                  side: BorderSide(color: Colors.blue)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              constraints: BoxConstraints(
                                  minWidth: 35.0, minHeight: 35.0),
                              onPressed: () {
                                print("user choose this to share");
                              },
                              elevation: 1.0,
                              fillColor: Colors.white,
                              splashColor: Colors.lightBlue[200],
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.share,
                                size: 25.0,
                                color: Colors.blue,
                              ),
                              shape: CircleBorder(
                                  side: BorderSide(color: Colors.blue)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          new TextSpan(
                              text: "Nguồn: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          new TextSpan(
                              text: storySource,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ])),
                        SizedBox(
                          height: 20,
                        ),
                        // content

                        Html(style: {
                          "body": Style(
                              color: Colors.black,
                              fontSize: FontSize.rem(1.15),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero)
                        }, data: storyDescription),

                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {Key? key, required this.title, required this.titleValue})
      : super(key: key);

  final String title;
  final String titleValue;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: new TextSpan(children: [
      new TextSpan(text: "$title:  ", style: kMediumDarkerTitleTextStyle),
      new TextSpan(text: "$titleValue", style: kMediumDarkerTitleTextStyle),
    ]));
  }
}
