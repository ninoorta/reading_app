import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/story_info/components/single_choice_chip_for_link.dart';
import 'package:reading_app/screens/story_info/menu_chapters_screen.dart';

class StoryInfo extends StatefulWidget {
  const StoryInfo({Key? key}) : super(key: key);

  @override
  _StoryInfoState createState() => _StoryInfoState();
}

class _StoryInfoState extends State<StoryInfo> {
  List<String> testTypeList = [
    "Ngôn tình",
    "Xuyên không",
    "Cổ đại",
    "Ngôn tình2",
    "Xuyên không2",
    "Cổ đại2",
  ];

  ScrollController _scrollController = ScrollController();

  String testText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
                text: testText,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16))
          ]),
        ),
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.pop(context),
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
                onPressed: null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.file_download,
                      color: Colors.blue,
                      size: 25,
                    ),
                    Text(
                      "Tải về",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  print("user want to read this one");
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
                onPressed: () {
                  pushNewScreen(context,
                      screen: MenuChapters(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino);
                },
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          // print(_scrollController.position.pixels);
          if (_scrollController.position.pixels > 35) {
            setState(() {
              testText =
                  "This is a text for test but it's so longggggggggggggggggggggggggggggggggggggggg";
            });
          } else if (_scrollController.position.pixels == 0 ||
              _scrollController.position.pixels < 30) {
            setState(() {
              testText = "";
            });
          }
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
                      Text("Tên truyện", style: kTitleTextStyle),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: new TextSpan(children: [
                                new TextSpan(
                                    text: "Tác giả:  ",
                                    style: kMediumDarkerTitleTextStyle),
                                new TextSpan(
                                    text: "Author name",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        print("click author name");
                                      })
                              ]),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            CustomRichText(
                                title: "Tình trạng", titleValue: "Đang ra"),
                            SizedBox(
                              height: 2.0,
                            ),
                            CustomRichText(
                                title: "Đăng gần nhất",
                                titleValue: "15 phút trước"),
                            SizedBox(
                              height: 2.0,
                            ),
                            CustomRichText(
                                title: "Số chương", titleValue: "20"),
                            SizedBox(
                              height: 2.0,
                            ),
                            CustomRichText(
                                title: "Lượt yêu thích", titleValue: "20"),
                            SizedBox(
                              height: 2.0,
                            ),
                            CustomRichText(
                                title: "Số người đã đọc", titleValue: "20009"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 50,
                          height: 100,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  SingleChoiceChipForLink(testTypeList),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RawMaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        constraints:
                            BoxConstraints(minWidth: 35.0, minHeight: 35.0),
                        onPressed: () {
                          print("user choose this as favorite one");
                        },
                        elevation: 1.0,
                        fillColor: Colors.white,
                        splashColor: Colors.lightBlue[200],
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.favorite_border,
                          size: 25.0,
                          color: Colors.blue,
                        ),
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.blue)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RawMaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        constraints:
                            BoxConstraints(minWidth: 35.0, minHeight: 35.0),
                        onPressed: () {
                          print("user choose this to write some comments");
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
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.blue)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RawMaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        constraints:
                            BoxConstraints(minWidth: 35.0, minHeight: 35.0),
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
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.blue)),
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
                        text: "Sưu tầm",
                        style: TextStyle(color: Colors.black, fontSize: 16))
                  ])),
                  SizedBox(
                    height: 20,
                  ),
                  // content

                  Html(
                      style: {
                        "body": Style(
                            color: Colors.black,
                            fontSize: FontSize.rem(1.15),
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero)
                      },
                      data:
                          "<b>Giới thiệu<br><br></b>Vũ Nhạc chỉ là vô tình bị ép nhận một chiếc vòng tay gắn chuông, không ngờ thế mà sau đó cô bị cuốn vào vô số phiền toái.<br><br>Không phải nói là vòng tay may mắn sao, sao cô thấy từ ngày mang nó, cô càng xui xẻo hơn vậy, đã thế còn dính vào một vụ cướp, sau đó, cô bị bắt làm con tin.<br><br>Và, như đã nói, cô ngày càng xui xẻo, chính vì thế, cô chết, bị một tên cảnh sát chả ra gì bắn nhầm, chết thẳng cẳng.<br><br>Tưởng mình được lên thiên đàng, nhưng không, bị một hệ thống vô dụng trói định, sau đó sai bảo cô đi làm nhiệm vụ.<br><br>Biết làm sao giờ, người ở dưới mái hiên, đành phải cúi đầu thôi.<br><br>Vì vậy, cô đành phải cố gắng hết mức, đi công lược các mục tiêu, ráng hoàn thành nhiệm vụ.<br><br>Nhưng mà hệ thống này là giả phải không? <br><br>VÔ DỤNG!<br><br>QUÁ VÔ DỤNG!!!!<br><br>Hệ thống đâu lăn ra cho bà!"),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {Key? key, required this.title, required this.titleValue})
      : super(key: key);

  final String title;
  final String titleValue;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: new TextSpan(children: [
      new TextSpan(text: "$title:  ", style: kMediumDarkerTitleTextStyle),
      new TextSpan(text: "$titleValue", style: kMediumDarkerTitleTextStyle),
    ]));
  }
}
