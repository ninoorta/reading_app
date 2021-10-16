import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/ads/ad_state.dart';
import 'package:reading_app/constants.dart';
import 'package:reading_app/screens/category/category_screen.dart';

// services
import 'package:reading_app/services/explore_screen_service.dart';

import 'components/build_skeleton_type_item.dart';
import 'components/build_type_item.dart';
import 'components/custom_listview.dart';
import 'other_group_screen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isLoading = true;
  dynamic exploreScreenData = {};
  List newStories = [];
  List recentUpdatedStories = [];
  List otherList = [];

  bool isBannerAdAlready = false;
  final List<String> typeList = [
    "Ngôn Tình",
    "Đam Mỹ",
    "Ngược",
    "Sủng",
    "Xuyên Không",
    "Đô Thị"
  ];

  bool isDarkModeEnabled = false;
  late BannerAd myBannerAd;
  late NativeAd myNativeAd;
  bool isNativeAdAlready = false;

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
      }),
    );

    myBannerAd.load();

    // remember to try for native ad later.
    getData();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    // final adState = context.read(adStateProvider);
    // adState.
  }

  Future<void> getData() async {
    exploreScreenData = await ExploreScreenService().getData();
    // print(exploreScreenData);
    newStories = exploreScreenData["new"];
    recentUpdatedStories = exploreScreenData["updated"];
    otherList = exploreScreenData["story_group"];

    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Truyện Gemmob",
          style: kTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          setState(() {
            isLoading = true;
            getData();
          });
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return true;
          },
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width - 30,
                      height: 50,
                      child: !isBannerAdAlready
                          ? Container()
                          : Container(
                              child: AdWidget(
                                ad: myBannerAd,
                              ),
                            ),
                    ),
                    CustomListView(
                      listName: "Mới Đăng",
                      isLoading: isLoading,
                      listData: newStories,
                      isNewPublish: true,
                    ),
                    this.isNativeAdAlready
                        ? AdWidget(ad: myNativeAd)
                        : Container(),
                    CustomListView(
                      listName: "Mới Cập Nhật",
                      isLoading: isLoading,
                      listData: recentUpdatedStories,
                      isNewPublish: false,
                    ),
                    // later
                    // CustomListView(
                    //     listName: "Truyện đọc gần đây", isLoading: isLoading),
                    // later
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text("Thể loại", style: kListTitleTextStyle),
                            TextButton(
                                onPressed: () {
                                  pushNewScreen(context,
                                      screen: CategoryScreen(
                                        fromOtherRoute: true,
                                      ),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino);
                                },
                                child: Text(
                                  "Xem thêm",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 50,
                                    crossAxisSpacing: 15.0,
                                    mainAxisSpacing: 15.0),
                            itemCount: typeList.length,
                            itemBuilder: (context, index) {
                              var currentType = typeList[index];
                              return isLoading
                                  ? BuildSkeletonTypeItem()
                                  : BuildTypeItem(
                                      type: currentType,
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Danh sách khác",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: otherList.length,
                          itemBuilder: (context, index) {
                            var currentItem = otherList[index];
                            var currentItemID = currentItem["_id"]["\$oid"];
                            var currentItemTitle = currentItem["title"];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: RichText(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                new TextSpan(
                                                    text: currentItem["title"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15))
                                              ])),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {
                                              print("move to $currentItemID");

                                              pushNewScreen(context,
                                                  screen: OtherGroupScreen(
                                                      groupID: currentItemID,
                                                      groupTitle:
                                                          currentItemTitle),
                                                  withNavBar: true,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino);
                                            },
                                            icon: Icon(Icons.arrow_forward_ios),
                                            padding: EdgeInsets.zero,
                                            color: Colors.grey[500],
                                            iconSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print("move to $currentItemID");
                                    pushNewScreen(context,
                                        screen: OtherGroupScreen(
                                            groupID: currentItemID,
                                            groupTitle: currentItemTitle),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino);
                                  },
                                ),
                                index != otherList.length - 1
                                    ? Divider(
                                        color: Colors.grey[500],
                                        thickness: 0.75,
                                        height: 2,
                                      )
                                    : SizedBox(
                                        height: 15.0,
                                      )
                              ],
                            );
                          },
                        ),
                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        // SizedBox(
                        //   height: 300,
                        //   child: GridView.builder(
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     gridDelegate:
                        //         SliverGridDelegateWithFixedCrossAxisCount(
                        //             crossAxisCount: 1,
                        //             mainAxisExtent: 65,
                        //             crossAxisSpacing: 0.0,
                        //             mainAxisSpacing: 0.0),
                        //     itemCount: otherList.length,
                        //     itemBuilder: (context, index) {
                        //       var currentItem = otherList[index];
                        //       var currentItemID = currentItem["_id"]["\$oid"];
                        //       var currentItemTitle = currentItem["title"];
                        //       return Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         // crossAxisAlignment: CrossAxisAlignment.stretch,
                        //         children: [
                        //           GestureDetector(
                        //             child: Container(
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 children: [
                        //                   Expanded(
                        //                     flex: 4,
                        //                     child: RichText(
                        //                         maxLines: 2,
                        //                         overflow: TextOverflow.ellipsis,
                        //                         text: TextSpan(children: [
                        //                           new TextSpan(
                        //                               text:
                        //                                   currentItem["title"],
                        //                               style: TextStyle(
                        //                                   color: Colors.black,
                        //                                   fontSize: 15))
                        //                         ])),
                        //                   ),
                        //                   Expanded(
                        //                     flex: 1,
                        //                     child: IconButton(
                        //                       onPressed: () {
                        //                         print("move to $currentItemID");
                        //
                        //                         pushNewScreen(context,
                        //                             screen: OtherGroupScreen(
                        //                                 groupID: currentItemID,
                        //                                 groupTitle:
                        //                                     currentItemTitle),
                        //                             withNavBar: true,
                        //                             pageTransitionAnimation:
                        //                                 PageTransitionAnimation
                        //                                     .cupertino);
                        //                       },
                        //                       icon:
                        //                           Icon(Icons.arrow_forward_ios),
                        //                       padding: EdgeInsets.zero,
                        //                       color: Colors.grey[500],
                        //                       iconSize: 20,
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //             onTap: () {
                        //               print("move to $currentItemID");
                        //               pushNewScreen(context,
                        //                   screen: OtherGroupScreen(
                        //                       groupID: currentItemID,
                        //                       groupTitle: currentItemTitle),
                        //                   withNavBar: true,
                        //                   pageTransitionAnimation:
                        //                       PageTransitionAnimation
                        //                           .cupertino);
                        //             },
                        //           ),
                        //           index != otherList.length - 1
                        //               ? Divider(
                        //                   color: Colors.grey[500],
                        //                   thickness: 0.75,
                        //                   height: 2,
                        //                 )
                        //               : SizedBox(
                        //                   height: 0.0,
                        //                 )
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 15.0,
                        // )
                      ],
                    )
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
