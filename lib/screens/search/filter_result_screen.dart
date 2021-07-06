import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reading_app/ads/ad_state.dart';
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
  int limit = 36;
  int pageNumber = 1;

  int full = 2;
  int maxChapter = 6000;
  int minChapter = 1;
  String sortType = "created";
  List<String> genres = [];

  ScrollController _scrollController = ScrollController();

  late BannerAd myBannerAd;

  bool isBannerAdAlready = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myBannerAd = BannerAd(
        adUnitId: AdState.bannerAdUnitID,
        size: AdSize.smartBanner,
        request: AdRequest(),
        listener: BannerAdListener(onAdClosed: (ad) {
          print("Closed Ad $ad");
        }, onAdOpened: (ad) {
          print("Opened Ad $ad");
        }, onAdLoaded: (ad) {
          print("ad loaded  $ad");
          setState(() {
            this.isBannerAdAlready = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print('Ad failed to load with error: $error');
          ad.dispose();
        }));
    myBannerAd.load();

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
        limit: limit,
        full: full,
        maxChapter: maxChapter,
        minChapter: minChapter,
        sortType: sortType,
        genres: genres);

    setState(() {
      resultData = resultData + apiResult;
      print("current offset $DiagnosticLevel.off");
      var startIndex = this.offset;
      if(this.offset > this.resultData.length){
        if(this.resultData.length == 36){
          startIndex = 0;
        } else {
          startIndex = ( (this.resultData.length ~/ 36)  - 1) * 36;
        }

      }
      for (var i = startIndex; i < this.resultData.length; i++) {
        if (i % 6 == 0) {
          if (this.resultData[i] is BannerAd) {
          } else {
            print("insert ad in index: $i");
            print("this title ${this.resultData[i]["title"]}");
            this.resultData.insert(
                i,
                BannerAd(
                    adUnitId: AdState.bannerAdUnitID,
                    size: AdSize.smartBanner,
                    request: AdRequest(),
                    listener: AdState.listener)
                  ..load());
          }
          i++;
        }
      }
      this.isLoadingMore = false;
    });
  }

  Future getData() async {
    this.isLoading = true;
    var apiResult = await SearchScreenService().getFilterData(
        offset: offset,
        limit: limit,
        full: full,
        maxChapter: maxChapter,
        minChapter: minChapter,
        sortType: sortType,
        genres: genres);

    setState(() {
      resultData = apiResult;

      print("run to this");
      if (resultData.isNotEmpty) {
        print("run to isNotEmpty, current offset $offset");
        var startIndex = this.offset;
        if(offset > this.resultData.length){
          startIndex = 0;
        }
        for (var i = startIndex; i < this.resultData.length; i++) {
          if (i % 6 == 0) {
            if (this.resultData[i] is BannerAd) {
            } else {
              print("insert ad in index: $i");
              print("this title ${this.resultData[i]["title"]}");
              this.resultData.insert(
                  i,
                  BannerAd(
                      adUnitId: AdState.bannerAdUnitID,
                      size: AdSize.smartBanner,
                      request: AdRequest(),
                      listener: AdState.listener)
                    ..load());
            }
            i++;
          }
        }
      }

      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
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
                          "Đi đến trang",
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
                            placeholder: "Nhập số trang",
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
                                this._scrollController.jumpTo(0);
                                getData();
                              });
                            },
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
                                this._scrollController.jumpTo(0);
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
                                  "Không có truyện nào phù hợp yêu cầu.",
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
                          : CustomTile(
                              currentItem: resultData[index],
                              key: Key(index.toString()),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
