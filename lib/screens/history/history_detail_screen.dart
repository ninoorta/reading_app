import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/database/story_db.dart';
import 'package:reading_app/screens/story_info/story_info.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:tiengviet/tiengviet.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({Key? key, required this.type, required this.isBlank})
      : super(key: key);

  final String type;
  final bool isBlank;

  // final List data;

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  List listToShow = [];
  List dataHolder = [];
  bool haveData = false;
  bool isDeleted = false;
  bool isLoading = true;
  late String tableName;

  late StoryDatabase storyDatabase;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("is read ${widget.type == "read"}");
    print("is Blank? ${widget.isBlank}");
    storyDatabase = StoryDatabase();
    if (!widget.isBlank && widget.type == "read") {
      // getLocalData();
      this.tableName = "RecentRead";
      getLocalData(tableName: this.tableName);
    } else if (!widget.isBlank && widget.type == "favorite") {
      this.tableName = "Favorite";
      getLocalData(tableName: this.tableName);
    } else {
      this.isLoading = false;
      this.haveData = false;
    }

    // recent read
    // favorite
    // downloaded
  }

  Future getLocalData({required String tableName}) async {
    var data = await storyDatabase.getData(tableName: tableName);
    setState(() {
      debugPrint("data from local $data", wrapWidth: 1024);
      listToShow = data;
      dataHolder = data;

      data == [] ? this.haveData = false : this.haveData = true;
      this.isLoading = false;
    });
    // storyDatabase.close();
  }

  List findWithName(String searchString) {
    List list = [];
    for (var i = 0; i < listToShow.length; i++) {
      if (TiengViet.parse(listToShow[i]["title"].trim().toLowerCase())
          .contains(TiengViet.parse(searchString))) {
        list.add(listToShow[i]);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đang Đọc",
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.pop(context, this.isDeleted),
        ),
        actions: [
          TextButton(
              onPressed: widget.isBlank == true
                  ? null
                  : () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("Xác Nhận"),
                          content: Text(
                            "Bạn muốn xóa tất cả ?",
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text(
                                  "Không",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () =>
                                    Navigator.pop(context, this.isDeleted)),
                            CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text(
                                  "Xóa Tất Cả",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                                onPressed: () async {
                                  await storyDatabase.deleteAll(
                                      tableName: this.tableName);
                                  await getLocalData(tableName: this.tableName);
                                  setState(() {
                                    this.isDeleted = true;
                                    Navigator.pop(context, this.isDeleted);
                                  });
                                }),
                          ],
                        ),
                      );
                    },
              child: Text(
                "Xóa Tất Cả",
                style: TextStyle(
                    color:
                        widget.isBlank == true ? Colors.grey[500] : Colors.blue,
                    fontSize: 20),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          setState(() {
            getLocalData(tableName: this.tableName);
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
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(bottom: 35),
                  child: haveData
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CupertinoSearchTextField(
                              controller: _textEditingController,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              placeholder: "Nhập tên truyện cần tìm",
                              prefixInsets:
                                  EdgeInsetsDirectional.fromSTEB(6, 2, 0, 4),
                              onChanged: (userInput) {
                                print("user $userInput");
                                setState(() {
                                  // listToShow = listToShow.contains(userInput)
                                  userInput = userInput.trim().toLowerCase();
                                  var holder = findWithName(userInput);
                                  if (holder == []) {
                                    this.haveData = false;
                                  } else {
                                    listToShow = holder;
                                  }
                                  if (userInput == "") {
                                    listToShow = dataHolder;
                                  }
                                });
                              },
                              onSuffixTap: () {
                                setState(() {
                                  _textEditingController.clear();
                                  this.listToShow = this.dataHolder;
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listToShow.length,
                              itemBuilder: (context, index) {
                                var currentItem = listToShow[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 4,
                                        child: GestureDetector(
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: StoryInfo(
                                                  storyID:
                                                      currentItem["storyID"],
                                                  fromHistory: true,
                                                ),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(children: [
                                                    new TextSpan(
                                                        text: currentItem[
                                                            "title"],
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18))
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 7.5,
                                                ),
                                                Text(currentItem["author"],
                                                    style:
                                                        kMediumBlackTitleTextStyle),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                    "${currentItem["chapter_count"]} chương",
                                                    style:
                                                        kMediumBlackTitleTextStyle),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                    "Đang xem: Chương ${currentItem["currentChapterNumber"]}",
                                                    style:
                                                        kMediumBlackTitleTextStyle),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              pushNewScreen(context,
                                                  screen: StoryInfo(
                                                    storyID:
                                                        currentItem["storyID"],
                                                    fromHistory: true,
                                                  ),
                                                  withNavBar: false,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino);
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: CachedNetworkImage(
                                                imageUrl: currentItem["cover"],
                                                width: 90,
                                                height: 120,
                                                progressIndicatorBuilder:
                                                    (context, url, progress) {
                                                  return SkeletonAnimation(
                                                    child: Container(
                                                      width: 90,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height,
                          child: Center(
                            child: Text(
                              isLoading ? "Đang tải..." : "Không có dữ liệu",
                              style: kTitleTextStyle,
                            ),
                          ),
                        )),
            ),
          ),
        ),
      ),
    );
  }
}
