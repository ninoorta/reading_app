import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/explore/components/custom_tile.dart';
import 'package:reading_app/screens/explore/components/custom_tile_skeleton.dart';
import 'package:reading_app/services/search_screen_service.dart';

class FilterResultScreen extends StatefulWidget {
  FilterResultScreen({required this.argumentsForGetData});

  final Map argumentsForGetData;

  @override
  _FilterResultScreenState createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  bool isLoading = true;
  bool isLoadingMore = false;
  List resultData = [];
  int offset = 0;
  int pageNumber = 1;

  int full = 2;
  int maxChapter = 6000;
  int minChapter = 1;
  String sortType = "created";
  List<String> genres = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    full = widget.argumentsForGetData["full"];
    maxChapter = widget.argumentsForGetData["max_chapter"];
    minChapter = widget.argumentsForGetData["min_chapter"];
    sortType = widget.argumentsForGetData["sortType"];
    genres = widget.argumentsForGetData["genres"];

    // print(widget.argumentsForGetData);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          setState(() {
            this.isLoadingMore = true;
            getMoreData();
          });
        }
      }
    });

    getData();
  }

  Future getMoreData() async {
    // limit = 36 ;

    setState(() {
      offset = offset + 36;
      this.pageNumber = this.pageNumber + 1;
    });

    var apiResult = await SearchScreenService().getFilterData(
        offset: offset,
        full: full,
        maxChapter: maxChapter,
        minChapter: minChapter,
        sortType: sortType,
        genres: genres);

    setState(() {
      resultData = resultData + apiResult;
      this.isLoadingMore = false;
    });
  }

  Future getData() async {
    this.isLoading = true;
    var apiResult = await SearchScreenService().getFilterData(
        offset: offset,
        full: full,
        maxChapter: maxChapter,
        minChapter: minChapter,
        sortType: sortType,
        genres: genres);

    setState(() {
      resultData = apiResult;
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "L???c Truy???n",
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
        height: 45.0,
        width: 45.0,
        margin: EdgeInsets.only(bottom: 10),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              print("user click to open dialog");
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text(
                          "??i ?????n trang",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: CupertinoTextField(
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.5)),
                            placeholder: "Nh???p s??? trang",
                            onChanged: (userInput) {
                              // print("userInput onChanged: $userInput");
                              setState(() {
                                // print("user input : $userInput");
                                // this.offset = 36 * (int.parse(userInput) - 1);
                                this.offset = 36 * (int.parse(userInput) - 1);
                              });
                            },
                            onSubmitted: (newValue) {
                              // print("user pressed enter $newValue");
                              setState(() {
                                // print("user input : $newValue");

                                this.offset = 36 * (int.parse(newValue) - 1);
                                this.pageNumber = int.parse(newValue);
                                Navigator.of(context).pop();

                                getData();
                              });
                            },
                          ),
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text(
                              "H???y",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            onPressed: () {
                              // print("user chose cancel");
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
                              // print("user chose ok");
                              Navigator.of(context).pop();
                              setState(() {
                                // print("current offset ${this.offset}");
                                this.pageNumber = (this.offset ~/ 36) + 1;
                                getData();
                              });
                            },
                          ),
                        ],
                      ));
            },
            child: Text(
              pageNumber.toString(),
              style: TextStyle(color: Colors.white, fontSize: 18),
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
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  isLoading
                      ? Container()
                      : resultData.length == 0
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: Center(
                                child: Text(
                                  "Kh??ng c?? truy???n n??o ph?? h???p y??u c???u.",
                                  style: kMediumDarkerTitleTextStyle,
                                ),
                              ),
                            )
                          : Container(),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: isLoading ? 10 : resultData.length,
                    itemBuilder: (context, index) {
                      return isLoading
                          ? CustomTileSkeleton()
                          : CustomTile(currentItem: resultData[index]);
                      // return Column(
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Expanded(
                      //           flex: 4,
                      //           child: Padding(
                      //             padding: EdgeInsets.only(right: 10.0),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   "T??n truy???n",
                      //                   style: TextStyle(
                      //                       color: Colors.blue, fontSize: 18),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 7.5,
                      //                 ),
                      //                 RichText(
                      //                     overflow: TextOverflow.ellipsis,
                      //                     text: TextSpan(children: [
                      //                       new TextSpan(
                      //                           text: "1 gi??? tr?????c  ",
                      //                           style:
                      //                               kMediumBlackTitleTextStyle),
                      //                       new TextSpan(
                      //                           text: "T??n t??c gi???",
                      //                           style: kMediumBlackTitleTextStyle)
                      //                     ])),
                      //                 SizedBox(
                      //                   height: 5.0,
                      //                 ),
                      //                 Text(
                      //                   "40 ch????ng",
                      //                   style: kMediumBlackTitleTextStyle,
                      //                 ),
                      //                 SizedBox(
                      //                   height: 5.0,
                      //                 ),
                      //                 RichText(
                      //                     overflow: TextOverflow.ellipsis,
                      //                     text: TextSpan(children: [
                      //                       new TextSpan(
                      //                           text: "Th??? lo???i 1 ",
                      //                           style:
                      //                               kMediumBlackTitleTextStyle),
                      //                       new TextSpan(
                      //                           text: "Th??? lo???i 2 ",
                      //                           style:
                      //                               kMediumBlackTitleTextStyle),
                      //                       new TextSpan(
                      //                           text: "Th??? lo???i 3 ",
                      //                           style:
                      //                               kMediumBlackTitleTextStyle),
                      //                       new TextSpan(
                      //                           text: "Th??? lo???i 4 ",
                      //                           style:
                      //                               kMediumBlackTitleTextStyle),
                      //                       new TextSpan(
                      //                           text: "Th??? lo???i 4 ",
                      //                           style:
                      //                               kMediumBlackTitleTextStyle),
                      //                     ]))
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Expanded(
                      //             flex: 1,
                      //             child: Container(
                      //               width: 50,
                      //               height: 100,
                      //               decoration: BoxDecoration(
                      //                   color: Colors.grey[300],
                      //                   borderRadius: BorderRadius.circular(5.0)),
                      //             ))
                      //       ],
                      //     ),
                      //     Divider(
                      //       height: 40.0,
                      //       thickness: 1.1,
                      //       color: Colors.black54,
                      //     )
                      //   ],
                      // );
                    },
                  ),
                  // isLoadingMore
                  //     ? Container(
                  //         padding: EdgeInsets.symmetric(vertical: 10),
                  //         child: CupertinoActivityIndicator(
                  //           radius: 20,
                  //         ),
                  //       )
                  //     : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
