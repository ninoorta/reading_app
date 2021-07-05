import 'package:flutter/cupertino.dart';
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
      required this.currentChapter,
      required this.chaptersCount,
      required this.isFavorite,
      required this.fromReading})
      : super(key: key);

  final String storyTitle;
  final String storyID;
  final int currentChapter;
  final int chaptersCount;
  final bool isFavorite;
  final bool fromReading;

  @override
  _MenuChaptersState createState() => _MenuChaptersState();
}

class _MenuChaptersState extends State<MenuChapters> {
  bool isLoading = true;
  bool haveReadAChapter = false;

  List chaptersData = [];

  int endChapterList = 1;
  int currentChapterList = 1;

  int endOffset = 50;
  int startOffset = 1;

  int chosenChapter = 1;

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
    var arguments = ModalRoute.of(context)!.settings.arguments;
    print("arguments $arguments");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.storyTitle,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: BackButton(
            color: Colors.blue,
            onPressed: () {
              if (haveReadAChapter) {
                Navigator.pop(context, this.chosenChapter);
              } else {
                Navigator.pop(context);
              }
            }),
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
                onPressed: currentChapterList == 1
                    ? null
                    : () {
                        setState(() {
                          currentChapterList = 1;
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
                  color:
                      currentChapterList == 1 ? Colors.grey[400] : Colors.blue,
                )),
            IconButton(
                onPressed: currentChapterList == 1
                    ? null
                    : () {
                        setState(() {
                          currentChapterList--;
                          startOffset = 1 + (currentChapterList - 1) * 50;
                          endOffset = currentChapterList * 50;

                          // callWhenCurrentChapterChange();
                          getData();
                        });
                      },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color:
                      currentChapterList == 1 ? Colors.grey[400] : Colors.blue,
                )),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    int inputPage = 1;
                    return CupertinoAlertDialog(
                      title: Text(
                        "Đi đến trang",
                        style: TextStyle(fontSize: 20),
                      ),
                      content: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: CupertinoTextField(
                          keyboardType: TextInputType.number,
                          placeholder: "Nhập số trang",
                          autofocus: true,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.5)),
                          onChanged: (userInput) {
                            setState(() {
                              inputPage = int.parse(userInput);
                              inputPage = inputPage < 1 ? 1 : inputPage;
                            });
                          },
                        ),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            "Hủy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          onPressed: () {
                            setState(() {
                              if (inputPage > this.endChapterList) {
                                this.currentChapterList = this.endChapterList;
                                this.startOffset =
                                    ((this.endChapterList - 1) * 50) + 1;
                                this.endOffset = this.endChapterList * 50;
                              } else {
                                this.startOffset = ((inputPage - 1) * 50) + 1;
                                this.endOffset = inputPage * 50;
                                this.currentChapterList = inputPage;
                              }
                              getData();
                              Navigator.pop(context);
                            });
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                  "$currentChapterList / $endChapterList",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
            IconButton(
                onPressed: currentChapterList == endChapterList
                    ? null
                    : () {
                        setState(() {
                          currentChapterList++;
                          print(
                              "current chapter before call changes $currentChapterList");
                          startOffset = 1 + (currentChapterList - 1) * 50;

                          if (currentChapterList != endChapterList) {
                            endOffset = currentChapterList * 50;
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
                  color: currentChapterList == endChapterList
                      ? Colors.grey[400]
                      : Colors.blue,
                )),
            IconButton(
                onPressed: currentChapterList == endChapterList
                    ? null
                    : () {
                        setState(() {
                          currentChapterList = endChapterList;
                          startOffset = (currentChapterList - 1) * 50 + 1;
                          endOffset = widget.chaptersCount;

                          // callWhenCurrentChapterChange();
                          getData();
                        });
                      },
                icon: Icon(
                  Icons.skip_next_rounded,
                  size: 30,
                  color: currentChapterList == endChapterList
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
          : NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return true;
              },
              child: Scrollbar(
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
                                if (widget.fromReading) {
                                  Navigator.pop(context, currentItem["number"]);
                                } else {
                                  // Navigator.pop(context);
                                  print(
                                      "chosen chapter ${currentItem["number"]}");
                                  pushNewScreen(
                                    context,
                                    screen: ReadingScreen(
                                      storyTitle: widget.storyTitle,
                                      storyID: widget.storyID,
                                      chaptersCount: widget.chaptersCount,
                                      currentChapterNumber:
                                          currentItem["number"],
                                      isFavorite: widget.isFavorite,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  ).then((chosenChapterNumber) {
                                    setState(() {
                                      print(
                                          "chapter user read $chosenChapterNumber");
                                      this.haveReadAChapter = true;
                                      this.chosenChapter = chosenChapterNumber;
                                    });
                                  });
                                }
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
                                        currentItem.containsKey("updated")
                                            ? Time()
                                                .getDate(currentItem["updated"])
                                            : "",
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
            ),
    );
  }
}
