import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  String sortType = "";
  String sortName = "";

  ScrollController _scrollController = ScrollController();

  bool isAdAlready = false;
  late BannerAd myBannerAd;
  late InterstitialAd myInterAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // BannerAd myBannerAd = BannerAd(
    //   adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    //   size: AdSize.banner,
    //   request: AdRequest(),
    //   listener: BannerAdListener(onAdClosed: (ad) {
    //     print("Closed Ad $ad");
    //   }, onAdOpened: (ad) {
    //     print("Opened Ad $ad");
    //   }, onAdLoaded: (_) {
    //     setState(() {
    //       this.isAdAlready = true;
    //     });
    //   }, onAdFailedToLoad: (ad, error) {
    //     print("bannerad $ad");
    //     print('Ad failed to load with error: $error');
    //     ad.dispose();
    //   }),
    // );

    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this.myInterAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
    // myBannerAd.load();
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

  Future getMoreData() async {
    setState(() {
      _scrollController.jumpTo(_scrollController.position.pixels + 15.0);

      this.isLoadingMore = true;
    });

    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: "created");

    setState(() {
      this.dataList = this.dataList + apiResult;

      this.isLoadingMore = false;
    });
  }

  Future getData() async {
    this.isLoading = true;
    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: sortType);

    setState(() {
      this.dataList = apiResult;

      this.isLoading = false;
    });
  }

  Future getNewPublishData() async {
    this.isLoading = true;
    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: "created");

    setState(() {
      this.dataList = apiResult;

      this.isLoading = false;
    });
  }

  Future getNewUpdateData() async {
    this.isLoading = true;
    var apiResult = await ExploreScreenService()
        .getListDetailData(offset: offset, sortType: "updated");

    setState(() {
      this.dataList = apiResult;
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
                              print("M???i nh???t");

                              setState(() {
                                sortType = "created";
                                sortName = "M???i Nh???t";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "M???i Nh???t",
                              style: TextStyle(color: Colors.red),
                            )),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("M???i C???p Nh???t");
                              setState(() {
                                sortType = "updated";
                                sortName = "M???i C???p Nh???t";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "M???i C???p Nh???t",
                              style: TextStyle(color: Colors.red),
                            )),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("Xem Nhi???u");
                              setState(() {
                                sortType = "view_count";
                                sortName = "Xem Nhi???u";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Xem Nhi???u",
                              style: TextStyle(color: Colors.red),
                            )),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              print("Y??u Th??ch");
                              setState(() {
                                sortType = "like_count";
                                sortName = "Y??u Th??ch";
                                this.getData();
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Y??u Th??ch",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          'H???y',
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
                    "??ang t???i...",
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
                      SizedBox(
                          height: 50,
                          child: this.isAdAlready
                              ? AdWidget(ad: myBannerAd)
                              : null),
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
                            return CustomTile(currentItem: currentItem);
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
