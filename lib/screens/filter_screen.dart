import 'package:flutter/material.dart';
import 'package:reading_app/components/multiple_choice_chip.dart';
import 'package:reading_app/components/single_choice_chip.dart';
import 'package:reading_app/constants.dart';
import 'package:smart_select/smart_select.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> typeList = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'News2',
    'Enter2tainment',
    'Politi2cs',
    'Automot2ive',
    'Spo2rts',
    'Education',
    'Fa2shion',
    'Tra2vel',
    'Food2',
    'Tech2',
    'Sci2ence',
    '3News',
    'Ente3rtainment',
    'P3olitics',
    'Au3tomotive',
    'Spo3rts',
    'Educ33ation',
    'Fashio3n',
    'Trave3l',
    'Foo3d',
    'Tech3',
    'Scie3nce',
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
    "Cập nhật",
    "Mới đăng",
    "Xem nhiều",
    "Yêu thích",
    "Số chương",
    "Đánh giá",
    "Toàn bộ",
  ];

  String selectedStatusCondition = "";
  String selectedChapterCondition = "";
  String selectedSortCondition = "";
  List<String> selectedTypeList = [];

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
      persistentFooterButtons: [
        Center(
          child: TextButton(
              style: ButtonStyle(),
              onPressed: () {
                print("press the filter btn");
              },
              child: Text("Filter")),
        )
      ],
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                          style: kFilterTitleTextStyle,
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
                          style: kFilterTitleTextStyle,
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
                          style: kFilterTitleTextStyle,
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
                          style: kFilterTitleTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        MultipleChoiceChip(typeList,
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
    );
  }
}
