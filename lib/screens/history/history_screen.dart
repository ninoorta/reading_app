import 'package:flutter/material.dart';
import 'package:reading_app/database/story_db.dart';

import '../../constants.dart';
import 'components/build_history_list.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isLoading = true;
  List recentReadData = [];
  late StoryDatabase storyDatabase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    storyDatabase = StoryDatabase();
    getLocalData();
  }

  Future getLocalData() async {
    print("${DateTime.now()} get localdata run");
    var data = await storyDatabase.getData();
    setState(() {
      recentReadData = data;
      // debugPrint("hey it's local recent read data $recentReadData",
      //     wrapWidth: 1024);
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Lịch Sử Đọc Truyện",
            style: kTitleTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            setState(() {
              getLocalData();
            });
          },
          child: Scrollbar(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.only(bottom: 10.0),
                  color: Colors.white,
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Center(
                              child: Container(
                                child: Text(
                                  "Đang tải...",
                                  style: kListTitleTextStyle,
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            BuildHistoryList(
                              title: "Đọc Gần Đây",
                              data: recentReadData.isEmpty
                                  ? null
                                  : recentReadData,
                              // forRefreshFunc: this.getLocalData(),
                            ),
                            BuildHistoryList(
                              title: "Yêu Thích Gần Đây",
                              // forRefreshFunc: this.getLocalData(),
                            ),
                            BuildHistoryList(
                              title: "Tải Gần Đây",
                              // forRefreshFunc: this.getLocalData(),
                            ),
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
