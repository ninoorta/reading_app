import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reading_app/constants.dart';

class HistoryDetail extends StatelessWidget {
  const HistoryDetail({Key? key}) : super(key: key);

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
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Xóa Tất Cả",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(bottom: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CupertinoSearchTextField(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  placeholder: "Nhập tên truyện cần tìm",
                  prefixInsets: EdgeInsetsDirectional.fromSTEB(6, 2, 0, 4),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(children: [
                                    new TextSpan(
                                        text: "Tên truyện",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 18))
                                  ]),
                                ),
                                SizedBox(
                                  height: 7.5,
                                ),
                                Text("Tên tác giả",
                                    style: kMediumBlackTitleTextStyle),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("50 chương",
                                    style: kMediumBlackTitleTextStyle),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("Đang xem: Chương 1",
                                    style: kMediumBlackTitleTextStyle),
                                SizedBox(
                                  height: 4,
                                ),
                              ],
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
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
