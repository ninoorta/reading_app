import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/category/category_screen.dart';
// services
import 'package:reading_app/services/explore_screen_service.dart';

import 'components/build_skeleton_type_item.dart';
import 'components/build_type_item.dart';
import 'components/custom_listview.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isLoading = true;
  dynamic exploreScreenData = {};
  List newStories = [];
  List recentUpdatedStories = [];

  final List<String> typeList = [
    "Ngôn Tình",
    "Đam Mỹ",
    "Ngược",
    "Sủng",
    "Xuyên Không",
    "Đô Thị"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     this.isLoading = false;
    //   });
    // });

    getData();
  }

  void getData() async {
    exploreScreenData = await ExploreScreenService().getData();
    // print(exploreScreenData);
    newStories = exploreScreenData["new"];
    recentUpdatedStories = exploreScreenData["updated"];

    setState(() {
      this.isLoading = false;
    });
  }

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          margin: EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: [
              CustomListView(
                listName: "Mới đăng",
                isLoading: isLoading,
                listData: newStories,
              ),
              CustomListView(
                listName: "Mới cập nhật",
                isLoading: isLoading,
                listData: recentUpdatedStories,
              ),
              // later
              // CustomListView(
              //     listName: "Truyện đọc gần đây", isLoading: isLoading),
              // later

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Thể loại", style: kListTitleTextStyle),
                      TextButton(
                          onPressed: () {
                            pushNewScreen(context,
                                screen: CategoryScreen(
                                  fromOtherRoute: true,
                                ),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino);
                          },
                          child: Text(
                            "Xem thêm",
                            style: TextStyle(color: Colors.blue, fontSize: 14),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 50,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0),
                      itemCount: typeList.length,
                      itemBuilder: (context, index) {
                        var currentType = typeList[index];
                        return isLoading
                            ? BuildSkeletonTypeItem()
                            : BuildTypeItem(
                                type: currentType,
                              );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
