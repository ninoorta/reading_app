import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/search_screen.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'category_screen.dart';
import 'explore_screen.dart';
import 'history_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;

  int pageIndex = 0;
  // List<Widget> pageList = <Widget>[
  //   CategoryScreen(),
  //   ExploreScreen(),
  //   SearchScreen(),
  //   HistoryScreen()
  // ];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(initialIndex: tabIndex, length: 4, vsync: this);

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
        print("5s passed");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int cupertinoTabBarValue = 0;
    int cupertinoTabBarValueGetter() => cupertinoTabBarValue;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hài hước",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue, width: 4.0),
              // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              // insets: EdgeInsets.only(top: 30)
            ),
            controller: _tabController,
            isScrollable: true,
            // indicatorColor: Colors.transparent,
            labelColor: Colors.blue,
            labelPadding:
                EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            tabs: <Widget>[
              Text("Mới Đăng"),
              Text("Mới Cập nhật"),
              Text("Full"),
              Text("Xem nhiều"),
            ],
          ),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.blue,
                ))
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: pageIndex,
        //   selectedLabelStyle: TextStyle(height: 1.25),
        //   onTap: (value) {
        //     print("click bottom item $value");
        //     setState(() {
        //       pageIndex = value;
        //
        //       // if (value == 0) {
        //       //   Navigator.pushNamed(context, "/category");
        //       // }
        //       // if (value == 1) {
        //       //   Navigator.pushNamed(context, "/explore");
        //       // }
        //       // if (value == 2) {
        //       //   Navigator.pushNamed(context, "/search");
        //       // }
        //       // if (value == 3) {
        //       //   Navigator.pushNamed(context, "/history");
        //       // }
        //
        //
        //     });
        //   },
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Thể loại"),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.explore), label: "Khám phá"),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.search), label: "Tìm Truyện"),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.history), label: "Lịch sử"),
        //   ],
        //   type: BottomNavigationBarType.fixed,
        // ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              CupertinoScrollbar(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return isLoading ? MyCustomTileSkeleton() : MyCustomTile();
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomTile extends StatelessWidget {
  const MyCustomTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                // color: Colors.grey,
                // constraints: BoxConstraints(
                //   minHeight: double.infinity,
                //   minWidth: double.infinity,
                // ),
                height: 80,
                // width: 65,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tru tiên",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          color: Colors.blue),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    Text(
                      "Hôm qua  - Chi Kim",
                      style: kSubTitleTextStyle,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Text(
                      "12 chương",
                      style: kSubTitleTextStyle,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Text(
                      "Ngôn Tình - Hài Hước - Kiếm Hiệp",
                      style: kSubTitleTextStyle,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCustomTileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SkeletonAnimation(
                child: Container(
                  // margin: EdgeInsets.only(top: 5),
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 18,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 14,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: 14,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 14,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildSkeletonItem extends StatelessWidget {
  final double width;
  final double height;

  BuildSkeletonItem({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.grey[300]),
      width: width,
      height: height,
    ));
  }
}
