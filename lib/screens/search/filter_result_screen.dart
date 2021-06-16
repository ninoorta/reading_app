import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_app/constants.dart';

class FilterResultScreen extends StatelessWidget {
  const FilterResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Lọc Truyện",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 50.0,
        width: 50.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              print("user click to open dialog");
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text(
                          "Đi đến trang",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: CupertinoTextField(
                            autofocus: true,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.5)),
                            placeholder: "Nhập số trang",
                          ),
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text(
                              "Hủy",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            onPressed: () {
                              print("user chose cancel");
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text("OK",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                            onPressed: () {
                              print("user chose ok");
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            },
            child: Text(
              "1",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      body: Scrollbar(
        thickness: 5,
        interactive: true,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tên truyện",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7.5,
                                    ),
                                    RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          new TextSpan(
                                              text: "1 giờ trước  ",
                                              style:
                                                  kMediumBlackTitleTextStyle),
                                          new TextSpan(
                                              text: "Tên tác giả",
                                              style: kMediumBlackTitleTextStyle)
                                        ])),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "40 chương",
                                      style: kMediumBlackTitleTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          new TextSpan(
                                              text: "Thể loại 1 ",
                                              style:
                                                  kMediumBlackTitleTextStyle),
                                          new TextSpan(
                                              text: "Thể loại 2 ",
                                              style:
                                                  kMediumBlackTitleTextStyle),
                                          new TextSpan(
                                              text: "Thể loại 3 ",
                                              style:
                                                  kMediumBlackTitleTextStyle),
                                          new TextSpan(
                                              text: "Thể loại 4 ",
                                              style:
                                                  kMediumBlackTitleTextStyle),
                                          new TextSpan(
                                              text: "Thể loại 4 ",
                                              style:
                                                  kMediumBlackTitleTextStyle),
                                        ]))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5.0)),
                                ))
                          ],
                        ),
                        Divider(
                          height: 40.0,
                          thickness: 1.1,
                          color: Colors.black54,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
