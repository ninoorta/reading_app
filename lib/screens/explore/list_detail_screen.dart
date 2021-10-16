import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reading_app/ads/ad_state.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/explore/components/custom_tile.dart';
import 'package:reading_app/services/explore_screen_service.dart';

class ListDetailScreen extends StatefulWidget {
  ListDetailScreen({required this.isNewPublish, required this.listName});

  bool isNewPublish;
  String listName;

  @override
  _ListDetailScreenState createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends State<ListDetailScreen> {
  bool isLoading = true;
  bool isLoadingMore = false;
  List dataList = [];

  int offset = 0;
  int limit = 20;
  String sortType = "";
  String sortName = "";

  ScrollController _scrollController = ScrollController();

  bool isBannerAdAlready = false;
  late BannerAd myBannerAd;
  late InterstitialAd myInterAd;

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

    print("start to build UI");
    print("isNewPublish ${widget.isNewPublish}");

    this.sortName = widget.listName;

    if (widget.isNewPublish) {
      this.getNewPublishData();
    } else {
      this.getNewUpdateData();
    }

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          this.getMoreData();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("change dependencies");
  }
  
  void showLoading() {
  }

  Future getMoreData() async {
    
    setState(() {
      this.isLoadingMore = true;
      // limit 20
      this.offset = this.offset + 20;
    });
    print("next offset $offset");

    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: "created", limit: limit);

    setState(() {
      this.dataList = this.dataList + apiResult;

      for (var i = offset; i < this.dataList.length; i++) {
        if (i % 8 == 0) {
          if (this.dataList[i] is BannerAd) {
          } else {
            print("insert ad in index: $i");
            print("this title ${this.dataList[i]["title"]}");
            this.dataList.insert(
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
    print("current sortType $sortType");

    setState(() {
      this.offset = 0;
    });
    this.isLoading = true;
    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: sortType, limit: limit);

    setState(() {
      this.dataList = apiResult;

      print("start to run a loop for");
      for (var i = this.offset; i < this.dataList.length; i++) {
        if (i % 8 == 0 && i != 0) {
          print("divide 8 ok");
          if (this.dataList[i] is BannerAd) {
          } else {
            this.dataList.insert(
                i,
                BannerAd(
                    adUnitId: AdState.bannerAdUnitID,
                    size: AdSize.smartBanner,
                    listener: AdState.listener,
                    request: AdRequest())..load());
          }
          i++;
        }
      }
      print("end the loop for");
      this.isLoading = false;
    });
  }

  Future getNewPublishData() async {
    this.isLoading = true;
    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: "created", limit: limit);

    setState(() {
      this.dataList = apiResult;

      for (var i = this.offset; i < this.dataList.length; i++) {
        if (i % 8 == 0 && i != 0) {
          print("divide 8 ok");
          if (this.dataList[i] is BannerAd) {
          } else {
            this.dataList.insert(
                i,
                BannerAd(
                    adUnitId: AdState.bannerAdUnitID,
                    size: AdSize.smartBanner,
                    listener: AdState.listener,
                    request: AdRequest())..load());
          }
          i++;
        }
      }

      this.isLoading = false;
    });
  }

  Future getNewUpdateData() async {
    this.isLoading = true;
    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: "updated", limit: limit);

    setState(() {
      this.dataList = apiResult;

      for (var i = this.offset; i < this.dataList.length; i++) {
        if (i % 8 == 0 && i != 0) {
          print("divide 8 ok");
          if (this.dataList[i] is BannerAd) {
          } else {
            this.dataList.insert(
                i,
                BannerAd(
                    adUnitId: AdState.bannerAdUnitID,
                    size: AdSize.smartBanner,
                    listener: AdState.listener,
                    request: AdRequest())..load());
          }
          i++;
        }
      }
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          sortName,
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.blue,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("Mới đăng");
                              setState(() {
                                sortType = "created";
                                sortName = "Mới Đăng";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Mới Nhất",
                              style: TextStyle(color: Colors.red),
                            )),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("Mới Cập Nhật");
                              setState(() {
                                sortType = "updated";
                                sortName = "Mới Cập Nhật";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Mới Cập Nhật",
                              style: TextStyle(color: Colors.red),
                            )),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("Xem Nhiều");
                              setState(() {
                                sortType = "view_count";
                                sortName = "Xem Nhiều";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Xem Nhiều",
                              style: TextStyle(color: Colors.red),
                            )),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("Yêu Thích");
                              setState(() {
                                sortType = "like_count";
                                sortName = "Yêu Thích";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Yêu Thích",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          'Hủy',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.sort,
                color: Colors.blue,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: this.isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(
                    radius: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Đang tải...",
                    style: kListTitleTextStyle,
                  )
                ],
              ),
            )
          : NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return true;
              },
              child: Scrollbar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        // margin: EdgeInsets.only(bottom: 20),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            var currentItem = dataList[index];
                            // debugPrint("current Item $currentItem", wrapWidth: 1024);
                            if (currentItem is BannerAd) {
                              print("it's bannerAd");
                              return Container(
                                  height: 70,
                                  child: AdWidget(
                                    ad: currentItem,
                                    key: Key(index.toString()),
                                  ));
                            } else {
                              return CustomTile(
                                currentItem: currentItem,
                                key: Key(index.toString()),
                              );
                            }
                          },
                        ),
                      ),
                      this.isLoadingMore
                          ? Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Center(
                                  child: CupertinoActivityIndicator(
                                radius: 20,
                              )),
                            )
                          : SizedBox(
                              height: 30,
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
