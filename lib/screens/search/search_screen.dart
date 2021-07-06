import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/ads/ad_state.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/search/filter_screen.dart';
import 'package:reading_app/services/search_screen_service.dart';

// components
import '../explore/components/custom_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  bool isLoadingMore = false;
  String userInput = "";
  int offset = 0;
  int limit = 36;
  List searchResultList = [];
  bool haveData = false;
  bool doesUserSearch = false;

  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  late BannerAd myBannerAd;
  bool isBannerAdAlready = false;
  void initState() {
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

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print("reach top");
        } else {
          print("reach bottom");
          setState(() {
            this.isLoadingMore = true;
          });
          getMoreData();
        }
      }
    });
  }

  Future getMoreData() async {
    // limit now is 36
    setState(() {
      offset = offset + 36;
    });
    var apiResult =
        await SearchScreenService().getData(keyword: userInput, offset: offset, limit: limit);

    setState(() {

      searchResultList = apiResult.isNotEmpty? searchResultList + apiResult: searchResultList;

      print("current offset");
      for (var i = offset; i < this.searchResultList.length; i++) {
        if (i % 6 == 0) {
          if(this.searchResultList[i] is BannerAd){

          } else {
            print("insert ad in index: $i");
            print("this title ${this.searchResultList[i]["title"]}");
            this.searchResultList.insert(
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

  Future getSearchData() async {
    print("user input now $userInput");
    if (this.userInput.trim() != "") {
      this.isLoading = true;

      var apiResult = await SearchScreenService()
          .getData(keyword: userInput, offset: offset, limit: limit);

      setState(() {
        searchResultList = apiResult;
        doesUserSearch = true;

        haveData = searchResultList.isNotEmpty ? true : false;

        if(haveData){
          for (var i = offset; i < this.searchResultList.length; i++) {
            if (i % 6 == 0) {
              if(this.searchResultList[i] is BannerAd){

              } else {
                print("insert ad in index: $i");
                print("this title ${this.searchResultList[i]["title"]}");
                this.searchResultList.insert(
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

        // debugPrint("search result $searchResultList", wrapWidth: 1024);
        this.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tìm Truyện',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                // print("time when click move to filter screen ${DateTime.now()}");
                pushNewScreen(
                  context,
                  screen: FilterScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              icon: Icon(
                Icons.filter_list,
                color: Colors.blue,
              ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: Scrollbar(
            interactive: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
              color: Colors.white,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CupertinoSearchTextField(
                        controller: _textEditingController,
                        placeholder: "Nhập tên truyện hoặc tác giả",
                        prefixInsets:
                            EdgeInsetsDirectional.fromSTEB(6, 5, 0, 4),
                        padding: EdgeInsetsDirectional.fromSTEB(7.5, 8, 5, 8),
                        onSuffixTap: () {
                          setState(() {
                            print("click cancel icon");
                            this.haveData = false;
                            this.doesUserSearch = false;
                            _textEditingController.clear();
                          });
                        },
                        onSubmitted: (userInput) {
                          print("userInput entered $userInput");
                          setState(() {
                            this.userInput = userInput;
                            getSearchData();
                          });
                        },
                      ),
                    ),
                    this.isLoading
                        ? Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: Text(
                                "Đang tải...",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        : haveData
                            ? Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    color: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: searchResultList.length,
                                          itemBuilder: (context, index) {
                                            var currentItem =
                                                searchResultList[index];
                                            return CustomTile(
                                                currentItem: currentItem);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            :
                            // guide text
                            Container(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    this.doesUserSearch
                                        ? Container(
                                            child: Text(
                                              "Không có kết quả tìm kiếm.",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                          )
                                        : Container(),
                                    Container(
                                      child: Text(
                                        'Để tìm kiếm chính xác hơn, bạn cần thêm dấu nháy " " vào cụm từ tìm kiếm của mình.',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 75),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              elevation: 0),
                                          onPressed: () {
                                            print(
                                                "click to move to filter screen");
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return FilterScreen();
                                              },
                                            ));
                                          },
                                          child: Text(
                                            "Tìm Với Bộ Lọc Truyện",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    isLoadingMore
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CupertinoActivityIndicator(
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Đang tải...",
                                  style: kListTitleTextStyle,
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
