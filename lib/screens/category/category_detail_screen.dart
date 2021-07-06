import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/ads/ad_state.dart';
import 'package:reading_app/screens/category/components/tabBar_content/most_favorite_content.dart';
import 'package:reading_app/screens/category/components/tabBar_content/most_view_content.dart';

// services
import 'package:reading_app/services/category_detail_screen_service.dart';

import '../search/filter_screen.dart';
import 'components/tabBar_content/new_publish_content.dart';
import 'components/tabBar_content/new_update_content.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String selectedGenre;

  CategoryDetailScreen({required this.selectedGenre});

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;

  int nextOffsetNewPublish = 0;
  int nextOffsetNewUpdate = 0;
  int nextOffsetMostView = 0;
  int nextOffsetMostLike = 0;

  int limitItem = 20;

  bool isLoading = true;
  bool isLoadingMore = false;

  List sort = ["created", "updated", "view_count", "like_count"];

  List newPublishData = [];
  List newUpdatedData = [];
  List mostViewData = [];
  List mostFavoriteData = [];

  String selectedSort = "";

  ScrollController _scrollController = ScrollController();

  late BannerAd myBannerAd;

  // bool isBannerAdAlready = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedSort = sort[0];

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

    _tabController =
        TabController(initialIndex: tabIndex, length: 4, vsync: this);

    _tabController.addListener(() {
      setState(() {
        print("index of tabbar change: ${_tabController.index}");
        tabIndex = _tabController.index;

        selectedSort = sort[tabIndex];
        // this.isLoading = true;
        getDataInitial();
      });
    });

    getDataInitial();
  }

  Future getMoreData() async {
    print("start to get more data from category detail screen");

    this.isLoadingMore = true;
    var nextOffset;

    if (tabIndex == 0) {
      nextOffset = nextOffsetNewPublish + limitItem;
    }
    if (tabIndex == 1) {
      nextOffset = nextOffsetNewUpdate + limitItem;
    }
    if (tabIndex == 2) {
      nextOffset = nextOffsetMostView + limitItem;
    }
    if (tabIndex == 3) {
      nextOffset = nextOffsetMostLike + limitItem;
    }
    var apiResult = await CategoryDetailScreenService().getData(
        genre: widget.selectedGenre,
        offset: nextOffset,
        sortType: selectedSort,
        limitItem: limitItem);

    setState(() {
      // newPublishData = newPublishData + apiResult;

      if (tabIndex == 0) {
        newPublishData = newPublishData + apiResult;


      }
      if (tabIndex == 1) {
        newUpdatedData = newUpdatedData + apiResult;

      }
      if (tabIndex == 2) {
        mostViewData = mostViewData + apiResult;

      }
      if (tabIndex == 3) {
        mostFavoriteData = mostFavoriteData + apiResult;

      }

      this.isLoadingMore = false;
    });
  }

  Future getDataInitial() async {
    // this.isLoading = true;
    var apiResult = await CategoryDetailScreenService().getData(
        genre: widget.selectedGenre,
        offset: 0,
        sortType: selectedSort,
        limitItem: limitItem);

    setState(() {
      if (tabIndex == 0) {
        newPublishData = apiResult;
      }
      if (tabIndex == 1) {
        newUpdatedData = apiResult;
      }
      if (tabIndex == 2) {
        mostViewData = apiResult;
      }
      if (tabIndex == 3) {
        mostFavoriteData = apiResult;
      }
      // newPublishData = apiResult;
      // debugPrint("data : $categoryDetailData", wrapWidth: 1024);
      // print("data in category detail screen : $categoryDetailData");

      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.selectedGenre,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue, width: 4.0),
              // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              // insets: EdgeInsets.only(top: 30)
            ),
            controller: _tabController,
            isScrollable: true,
            // indicatorColor: Colors.transparent,
            labelColor: Colors.blue,
            labelPadding:
                EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            tabs: <Widget>[
              Text("Mới Đăng"),
              Text("Mới Cập nhật"),
              Text("Xem Nhiều"),
              Text("Yêu Thích"),
            ],
          ),
          leading: BackButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: FilterScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.blue,
                ))
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 25, top: 10, left: 15, right: 15),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              NewPublishContent(
                  selectedGenre: widget.selectedGenre,
                  sortType: sort[0],
                  limitItem: limitItem),
              NewUpdateContent(
                  selectedGenre: widget.selectedGenre,
                  sortType: sort[1],
                  limitItem: limitItem),
              MostViewContent(
                  selectedGenre: widget.selectedGenre,
                  sortType: sort[2],
                  limitItem: limitItem),
              MostFavoriteContent(
                  selectedGenre: widget.selectedGenre,
                  sortType: sort[3],
                  limitItem: limitItem),
            ],
          ),
        ),
      ),
    );
  }
}
