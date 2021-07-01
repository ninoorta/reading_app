import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/explore/components/custom_tile_skeleton.dart';
// services

import 'package:reading_app/services/explore_screen_service.dart';

import 'components/custom_tile.dart';

class OtherGroupScreen extends StatefulWidget {
  OtherGroupScreen({
    required this.groupID,
    required this.groupTitle,
  });

  final String groupTitle;
  final String groupID;

  @override
  _OtherGroupScreenState createState() => _OtherGroupScreenState();
}

class _OtherGroupScreenState extends State<OtherGroupScreen> {
  bool isLoading = true;
  int nextOffset = 0;
  List groupData = [];

  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     this.isLoading = false;
    //   });
    // });
    getData();
  }

  Future getMoreData() async {}

  Future getData() async {
    var apiResult = await ExploreScreenService()
        .getGroupData(groupID: widget.groupID, groupOffset: nextOffset);

    setState(() {
      groupData = apiResult;
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.groupTitle,
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: Scrollbar(
          interactive: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: isLoading ? 10 : groupData.length,
                      itemBuilder: (context, index) {
                        return isLoading
                            ? CustomTileSkeleton()
                            : CustomTile(
                                currentItem: groupData[index],
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
