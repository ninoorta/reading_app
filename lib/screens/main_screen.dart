import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/category/category_screen.dart';
import 'package:reading_app/screens/explore/explore_screen.dart';
import 'package:reading_app/screens/history/history_screen.dart';
import 'package:reading_app/screens/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  // int pageIndex = 0;

  // List<Widget> pageList = [
  //   CategoryScreen(),
  //   ExploreScreen(),
  //   SearchScreen(),
  //   HistoryScreen()
  // ];

  List<Widget> _buildScreens() {
    return [
      CategoryScreen(
        fromOtherRoute: false,
      ),
      ExploreScreen(),
      SearchScreen(),
      HistoryScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),
        title: ("Thể loại"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.explore),
        title: ("Khám phá"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Tìm truyện"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: ("Đã đọc"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context, controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          colorBehindNavBar: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.25, //extend the shadow
              offset: Offset(
                0, // Move to right 10  horizontally
                0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );

    // return FutureBuilder(
    //   future: _initGoogleMobileAds(),
    //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
    //     print("snapshot ${snapshot.hasData}");
    //     print("snapshot $snapshot");
    //     if (snapshot.hasData) {
    //       return PersistentTabView(
    //         context, controller: _controller,
    //         screens: _buildScreens(),
    //         items: _navBarsItems(),
    //         confineInSafeArea: true,
    //         backgroundColor: Colors.white,
    //         // Default is Colors.white.
    //         handleAndroidBackButtonPress: true,
    //         // Default is true.
    //         resizeToAvoidBottomInset: true,
    //         // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //         stateManagement: true,
    //         // Default is true.
    //         hideNavigationBarWhenKeyboardShows: true,
    //         // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //         decoration: NavBarDecoration(
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(15.0),
    //                 topRight: Radius.circular(15.0)),
    //             colorBehindNavBar: Colors.white,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.35),
    //                 blurRadius: 1.0, // soften the shadow
    //                 spreadRadius: 1.25, //extend the shadow
    //                 offset: Offset(
    //                   0, // Move to right 10  horizontally
    //                   0, // Move to bottom 10 Vertically
    //                 ),
    //               )
    //             ]),
    //         popAllScreensOnTapOfSelectedTab: true,
    //         popActionScreens: PopActionScreensType.all,
    //         itemAnimationProperties: ItemAnimationProperties(
    //           // Navigation Bar's items animation properties.
    //           duration: Duration(milliseconds: 200),
    //           curve: Curves.ease,
    //         ),
    //         screenTransitionAnimation: ScreenTransitionAnimation(
    //           // Screen transition animation on change of selected tab.
    //           animateTabTransition: true,
    //           curve: Curves.ease,
    //           duration: Duration(milliseconds: 200),
    //         ),
    //         navBarStyle: NavBarStyle.style6,
    //       );
    //     } else if (snapshot.hasError) {
    //       return Scaffold(
    //         body: Center(
    //             child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Icon(
    //               Icons.error_outline,
    //               color: Colors.red,
    //               size: 60,
    //             )
    //           ],
    //         )),
    //       );
    //     } else
    //       return Scaffold(
    //         body: Center(
    //             child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             SizedBox(
    //               child: CircularProgressIndicator(),
    //               width: 48,
    //               height: 48,
    //             )
    //           ],
    //         )),
    //       );
    //   },
    // );
  }
}
