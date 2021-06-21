import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/reading_screen.dart';
import 'package:reading_app/services/story_info_screen_service.dart';
// utilities
import 'package:reading_app/utilities/time.dart';

class MenuChapters extends StatefulWidget {
  const MenuChapters(
      {Key? key,
      required this.storyTitle,
      required this.storyID,
      required this.chaptersCount})
      : super(key: key);

  final String storyTitle;
  final String storyID;
  final int chaptersCount;

  @override
  _MenuChaptersState createState() => _MenuChaptersState();
}

class _MenuChaptersState extends State<MenuChapters> {
  bool isLoading = true;

  List chaptersData = [];

  int endChapterList = 1;
  int currentChapter = 1;

  int endOffset = 50;
  int startOffset = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    endChapterList = (widget.chaptersCount / 50).ceil();
    getData();
  }

  Future getData() async {
    isLoading = true;
    print("start to load");

    var apiResult = await StoreInfoScreenService(storeID: widget.storyID)
        .getChaptersData(startOffset: startOffset, endOffset: endOffset);

    setState(() {
      chaptersData = apiResult;

      if (chaptersData.length > 50) {
        endChapterList = chaptersData.length % 50;
      }
      isLoading = false;
      // print("current chaptersData $chaptersData");
    });
  }

  Future callWhenCurrentChapterChange() async {
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.storyTitle,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            // padding: EdgeInsets.only(right: 15.0),
            onPressed: () {
              setState(() {
                getData();
                print(chaptersData);
              });
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.blue,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: currentChapter == 1
                    ? null
                    : () {
                        setState(() {
                          currentChapter = 1;
                          startOffset = 0;
                          endOffset = widget.chaptersCount > 50
                              ? 50
                              : widget.chaptersCount;
                          // callWhenCurrentChapterChange();
                          getData();
                        });
                      },
                icon: Icon(
                  Icons.skip_previous_rounded,
                  size: 30,
                  color: currentChapter == 1 ? Colors.grey[400] : Colors.blue,
                )),
            IconButton(
                onPressed: currentChapter == 1
                    ? null
                    : () {
                        setState(() {
                          currentChapter--;
                          startOffset = 1 + (currentChapter - 1) * 50;
                          endOffset = currentChapter * 50;

                          // callWhenCurrentChapterChange();
                          getData();
                        });
                      },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: currentChapter == 1 ? Colors.grey[400] : Colors.blue,
                )),
            Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                "$currentChapter / $endChapterList",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              )),
            ),
            IconButton(
                onPressed: currentChapter == endChapterList
                    ? null
                    : () {
                        setState(() {
                          currentChapter++;
                          print(
                              "current chapter before call changes $currentChapter");
                          startOffset = 1 + (currentChapter - 1) * 50;

                          if (currentChapter != endChapterList) {
                            endOffset = currentChapter * 50;
                          } else {
                            endOffset = widget.chaptersCount;
                          }
                          ;
                          // callWhenCurrentChapterChange();

                          getData();
                        });
                      },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: currentChapter == endChapterList
                      ? Colors.grey[400]
                      : Colors.blue,
                )),
            IconButton(
                onPressed: currentChapter == endChapterList
                    ? null
                    : () {
                        setState(() {
                          currentChapter = endChapterList;
                          startOffset = (currentChapter - 1) * 50 + 1;
                          endOffset = widget.chaptersCount;

                          // callWhenCurrentChapterChange();
                          getData();
                        });
                      },
                icon: Icon(
                  Icons.skip_next_rounded,
                  size: 30,
                  color: currentChapter == endChapterList
                      ? Colors.grey[400]
                      : Colors.blue,
                )),
          ],
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
          : Scrollbar(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  // height: 500,
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:
                        chaptersData.length >= 50 ? 50 : chaptersData.length,
                    itemBuilder: (context, index) {
                      var currentItem = chaptersData[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: ReadingScreen(
                                    storyTitle: widget.storyTitle,
                                    storyID: widget.storyID,
                                    chapterCount: widget.chaptersCount,
                                    currentChapter: currentItem["number"],
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      currentItem["title"],
                                      style: TextStyle(
                                          color: Colors.grey[850],
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      Time().getDate(currentItem["updated"]),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Divider(
                            color: Colors.black54,
                            thickness: 0.75,
                          )
                        ],
                      );
                    },
                  )),
            ),
    );
  }
}
