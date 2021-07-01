import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/search/components/multiple_choice_chip.dart';
import 'package:reading_app/screens/search/components/single_choice_chip.dart';
import 'package:reading_app/screens/search/filter_result_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> categoryList = [
    "Ngôn Tình",
    "Ngược",
    "Đam Mỹ",
    "Hài Hước",
    "Đô Thị",
    "Xuyên Không",
    "Xuyên Nhanh",
    "Truyện Teen",
    "Kiếm Hiệp",
    "Tiên Hiệp",
    "Sắc",
    "Sủng",
    "Mạt Thế",
    "Bách Hợp",
    "Đông Phương",
    "Cung Đấu",
    "Gia Đấu",
    "Cổ Đại",
    "Điền Văn",
    "Nữ Cường",
    "Nữ Phụ",
    "Trinh Thám",
    "Quan Trường",
    "Dị Năng",
    "Dị Giới",
    "Võng Du",
    "Linh Dị",
    "Trọng Sinh",
    "Quân Sự",
    "Lịch Sử",
    "Thám Hiểm",
    "Huyền Huyễn",
    "Khoa Huyễn",
    "Hệ Thống",
    "Tiểu Thuyết",
    "Phương Tây",
    "Việt Nam",
    "Đoản Văn",
    "Khác",
  ];

  List<String> statusConditionList = ["Tất cả", "Full", "Đang ra"];
  List<String> chapterConditionList = [
    "Tất cả",
    "Ít hơn 50",
    "Ít hơn 100",
    "100 ~ 200",
    "Ít hơn 200",
    "200 ~ 500",
    "Ít hơn 500",
    "500 ~ 1000",
    "Ít hơn 1000",
    "Lớn hơn 1000",
  ];
  List<String> sortConditionList = [
    "Cập Nhật",
    "Mới Đăng",
    "Xem Nhiều",
    "Yêu Thích",
    "Số Chương",
    "Đánh Giá",
    "Toàn Bộ",
  ];

  String selectedStatusCondition = "";
  String selectedChapterCondition = "";
  String selectedSortCondition = "";
  List<String> selectedTypeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedStatusCondition = statusConditionList[0];
    selectedChapterCondition = chapterConditionList[0];
    selectedSortCondition = sortConditionList[0];
  }

  @override
  Widget build(BuildContext context) {
    // print("time in filter screen ${DateTime.now()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lọc truyện",
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blue,
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(bottom: 15),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              print("user click to get filter result");

              print("selected status condition $selectedStatusCondition");
              print("selected chapter condition $selectedChapterCondition");
              print("selected sort condition $selectedSortCondition");
              print("selected type  $selectedTypeList");

              int full = 2, max = 6000, min = 1;
              String sortType = "updated";

              switch (selectedStatusCondition) {
                case "Tất cả":
                  full = 2;
                  break;
                case "Full":
                  full = 1;
                  break;
                case "Đang ra":
                  full = 0;
                  break;
              }
              ;

              switch (selectedChapterCondition) {
                case "Tất cả":
                  max = 6000;
                  min = 1;
                  break;
                case "Ít hơn 50":
                  max = 50;
                  min = 1;
                  break;
                case "Ít hơn 100":
                  max = 100;
                  min = 1;
                  break;
                case "100 ~ 200":
                  max = 200;
                  min = 100;
                  break;
                case "Ít hơn 200":
                  max = 200;
                  min = 1;
                  break;
                case "200 ~ 500":
                  max = 500;
                  min = 200;
                  break;
                case "Ít hơn 500":
                  max = 500;
                  min = 1;
                  break;
                case "500 ~ 1000":
                  max = 1000;
                  min = 500;
                  break;
                case "Ít hơn 1000":
                  max = 1000;
                  min = 1;
                  break;
                case "Lớn hơn 1000":
                  max = 6000;
                  min = 1000;
                  break;
              }
              ;

              switch (selectedSortCondition) {
                case "Cập Nhật":
                  sortType = "updated";
                  break;
                case "Mới Đăng":
                  sortType = "created";
                  break;
                case "Xem Nhiều":
                  sortType = "view_count";
                  break;
                case "Yêu Thích":
                  sortType = "like_count";
                  break;
                case "Số Chương":
                  sortType = "chapter_count";
                  break;
                case "Đánh Giá":
                  sortType = "star";
                  break;
                case "Toàn Bộ":
                  sortType = "all";
                  break;
              }

              // print("status $full");
              //
              // print("chapter min $min");
              // print("chapter max $max");
              //
              // print("sort $sortType");

              pushNewScreen(context,
                  screen: FilterResultScreen(
                    argumentsForGetData: {
                      "full": full,
                      "max_chapter": max,
                      "min_chapter": min,
                      "sortType": sortType,
                      "genres": this.selectedTypeList
                    },
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino);
            },
            child: Icon(
              Icons.filter_list,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: Scrollbar(
          thickness: 5,
          interactive: true,
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                // padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trạng thái".toUpperCase(),
                            style: kMediumBlackTitleTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SingleChoiceChip(statusConditionList,
                              onSelectChange: (selectedChoice) {
                            setState(() {
                              selectedStatusCondition = selectedChoice;
                            });
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Số chương".toUpperCase(),
                            style: kMediumBlackTitleTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SingleChoiceChip(chapterConditionList,
                              onSelectChange: (selectedChoice) {
                            setState(() {
                              selectedChapterCondition = selectedChoice;
                            });
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sắp xếp".toUpperCase(),
                            style: kMediumBlackTitleTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SingleChoiceChip(sortConditionList,
                              onSelectChange: (selectedChoice) {
                            setState(() {
                              selectedSortCondition = selectedChoice;
                            });
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thể loại".toUpperCase(),
                            style: kMediumBlackTitleTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          MultipleChoiceChip(categoryList,
                              onSelectChange: (selectedList) {
                            setState(() {
                              selectedTypeList = selectedList;
                            });
                          }),
                        ],
                      ),
                    ),
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
