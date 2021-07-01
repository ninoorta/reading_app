import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/database/story_db.dart';
import 'package:reading_app/models/story.dart';
import 'package:reading_app/screens/story_info/components/single_choice_chip_for_link.dart';
import 'package:reading_app/screens/story_info/menu_chapters_screen.dart';
import 'package:reading_app/screens/story_info/reading_screen.dart';
// services
import "package:reading_app/services/story_info_screen_service.dart";
import 'package:reading_app/utilities/time.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'components/custom_rich_text.dart';

class StoryInfo extends StatefulWidget {
  StoryInfo({Key? key, required this.storyID, required this.fromHistory})
      : super(key: key);
  String storyID = "";
  bool fromHistory;

  @override
  _StoryInfoState createState() => _StoryInfoState();
}

class _StoryInfoState extends State<StoryInfo> {
  bool isLoading = true;
  bool isFavorite = false;

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
  int currentChapterNumber = 1;
  bool usedToRead = false;

  List storyGenres = [];

  String storySource = "";

  String storyDescription = "";

  ScrollController _scrollController = ScrollController();

  Map timeData = {};
  late StoryDatabase storyDatabase;

  List test = [];

  bool _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("storyID: ${widget.storyID}");
    storyDatabase = StoryDatabase();
    getDataFromAPI();
  }

  Future getDataFromDB() async {
    var localData = await storyDatabase.getData(tableName: "RecentRead");
    debugPrint("local data $localData");
    setState(() {
      for (int i = 0; i < localData.length; i++) {
        if (localData[i]["storyID"] == widget.storyID) {
          this.currentChapterNumber = localData[i]["currentChapterNumber"];
          this.usedToRead = true;
        }
      }
    });
  }

  Future getDataFromAPI() async {
    storyData = await StoreInfoScreenService(storeID: widget.storyID).getData();
    // await getDataFromDB();

    var findRecentReadResult = await storyDatabase.findWithStoryID(
        tableName: "RecentRead", storyID: widget.storyID);
    var findFavoriteResult = await storyDatabase.findWithStoryID(
        tableName: "Favorite", storyID: widget.storyID);

    timeData = Time().convertTimeToDHMS(
        startTime: storyData["updated"],
        endTime: (DateTime.now().millisecondsSinceEpoch / 1000).ceil());

    setState(() {
      if (!findRecentReadResult.isEmpty) {
        this.currentChapterNumber =
            findRecentReadResult[0]["currentChapterNumber"];
        this.usedToRead = true;
        print("current ChapterNumber $currentChapterNumber");
      } else {
        print("user never reads this one before");
      }
      if (!findFavoriteResult.isEmpty) {
        print("user likes this one");
        this.isFavorite = true;
      } else {
        print("user never likes this one before");
      }

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
          onPressed: () {
            if (widget.fromHistory) {
              Navigator.pop(context, this.isFavorite);
            } else {
              Navigator.pop(context);
            }
          },
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
                // later
                // onPressed: this.isLoading
                //     ? null
                //     : () {
                //         pushNewScreen(context,
                //             screen: DownloadScreen(),
                //             withNavBar: false,
                //             pageTransitionAnimation:
                //                 PageTransitionAnimation.cupertino);
                //       },
                onPressed: null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.file_download,
                      color: Colors.grey[400],
                      // color: Colors.blue,
                      size: 25,
                    ),
                    Text(
                      "Tải về",
                      style: TextStyle(
                          color: Colors.grey[400],
                          // color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: this.isLoading
                    ? null
                    : () {
                        print("user want to read this one");

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ReadingScreen(
                              storyTitle: storyTitle,
                              storyID: widget.storyID,
                              currentChapterNumber: currentChapterNumber,
                              chaptersCount: storyChapters,
                              isFavorite: this.isFavorite,
                            );
                          },
                        )).then((newChapterNumber) => setState(() {
                              print("receive $newChapterNumber");
                              this.currentChapterNumber = newChapterNumber;
                              this.usedToRead = true;
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
                onPressed: this.isLoading
                    ? null
                    : () {
                        pushNewScreen(context,
                                screen: MenuChapters(
                                  storyTitle: storyTitle,
                                  storyID: widget.storyID,
                                  currentChapter: currentChapterNumber,
                                  chaptersCount: storyChapters,
                                  isFavorite: this.isFavorite,
                                  fromReading: false,
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino)
                            .then((chosenChapter) {
                          print("result from menuchapter $chosenChapter");
                          if (chosenChapter != null) {
                            setState(() {
                              this.usedToRead = true;
                              this.currentChapterNumber = chosenChapter;
                            });
                          }
                        });
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
              child: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  setState(() {
                    this.isLoading = true;
                    getDataFromAPI();
                  });
                },
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: new TextSpan(children: [
                                          new TextSpan(
                                              text: "Tác giả: ",
                                              style:
                                                  kMediumDarkerTitleTextStyle),
                                          new TextSpan(
                                              text: storyAuthor,
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      print(
                                                          "click author name");
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
                                          titleValue:
                                              storyViewedCount.toString()),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      usedToRead
                                          ? CustomRichText(
                                              title: "Chương đang đọc",
                                              titleValue: currentChapterNumber
                                                  .toString())
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 50,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        errorWidget: (context, url, error) {
                                          return SkeletonAnimation(
                                              child: Container(
                                            width: 50,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ));
                                        },
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                SkeletonAnimation(
                                                    child: Container(
                                          width: 50,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        )),
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
                                    // print("user choose this as favorite one");
                                    if (this.isFavorite == true) {
                                      setState(() {
                                        this.isFavorite = false;
                                        storyDatabase.deleteOne(
                                            tableName: "Favorite",
                                            storyID: widget.storyID);
                                      });
                                    } else {
                                      setState(() {
                                        this.isFavorite = true;
                                        storyDatabase.insertStory(
                                            tableName: "Favorite",
                                            story: StoryModel(
                                                storyID: widget.storyID,
                                                author: storyAuthor,
                                                cover: storyImageCoverURL,
                                                full: storyData["full"] ? 1 : 0,
                                                title: storyTitle,
                                                chapter_count: storyChapters,
                                                currentChapterNumber:
                                                    currentChapterNumber));
                                      });
                                    }
                                    print("current favorite $isFavorite");
                                  },
                                  elevation: 1.0,
                                  fillColor: Colors.white,
                                  splashColor: Colors.lightBlue[200],
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    this.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 25.0,
                                    color: this.isFavorite
                                        ? Colors.red
                                        : Colors.blue,
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16))
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
              ),
            ),
    );
  }
}
