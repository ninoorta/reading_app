import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reading_app/ads/ad_state.dart';
import 'package:reading_app/database/story_db.dart';
import 'package:reading_app/models/story.dart';

// services
import 'package:reading_app/services/story_detail_screen_service.dart';
import 'package:reading_app/services/story_info_screen_service.dart';

import 'menu_chapters_screen.dart';

class ReadingScreen extends StatefulWidget {
  ReadingScreen(
      {Key? key,
      required this.storyTitle,
      required this.storyID,
      required this.chaptersCount,
      required this.currentChapterNumber,
      required this.isFavorite})
      : super(key: key);

  final String storyID;
  final String storyTitle;
  final int chaptersCount;
  final int currentChapterNumber;
  final bool isFavorite;

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  bool visible = false;
  bool isLoading = true;
  Map storyData = {};
  Map storyToStore = {};

  String chapterTitle = "";
  String chapterContent = "";
  int currentChapterNumber = 1;

  late StoryDatabase storyDatabase = StoryDatabase();

  List test = [];

  late InterstitialAd _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    visible = true;
    currentChapterNumber = widget.currentChapterNumber;
    print("user current chapter number $currentChapterNumber");


    InterstitialAd.load(
        adUnitId: AdState.interstitialAdUnitID,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              print("interstitial ad loaded");
              this._interstitialAd = ad;

              this._interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (InterstitialAd ad) =>
                    print('$ad onAdShowedFullScreenContent.'),
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
                  print('$ad onAdDismissedFullScreenContent.');
                  ad.dispose();
                },
                onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                  print('$ad onAdFailedToShowFullScreenContent: $error');
                  ad.dispose();
                },
                onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
              );
            },
            onAdFailedToLoad: (LoadAdError error) =>
                print('Interstitial failed to load: $error')));

    getData();

  }

  void dispose() {
    super.dispose();
  }

  Future getStoryDataToStore() async {
    var apiResult =
        await StoreInfoScreenService(storeID: widget.storyID).getData();
    this.storyToStore = apiResult;

    await storyDatabase.insertStory(
        tableName: "RecentRead",
        story: StoryModel(
            storyID: widget.storyID,
            author: storyToStore["author"],
            cover: storyToStore["cover"],
            full: storyToStore["full"] == true ? 1 : 0,
            title: storyToStore["title"],
            chapter_count: storyToStore["chapter_count"],
            currentChapterNumber: this.currentChapterNumber));

    if (widget.isFavorite) {
      await storyDatabase.insertStory(
          tableName: "Favorite",
          story: StoryModel(
              storyID: widget.storyID,
              author: storyToStore["author"],
              cover: storyToStore["cover"],
              full: storyToStore["full"] == true ? 1 : 0,
              title: storyToStore["title"],
              chapter_count: storyToStore["chapter_count"],
              currentChapterNumber: this.currentChapterNumber));
    }
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdState.interstitialAdUnitID,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              print("interstitial ad loaded");
              this._interstitialAd = ad;

              this._interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (InterstitialAd ad) =>
                    print('$ad onAdShowedFullScreenContent.'),
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
                  print('$ad onAdDismissedFullScreenContent.');
                  ad.dispose();
                },
                onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                  print('$ad onAdFailedToShowFullScreenContent: $error');
                  ad.dispose();
                  // this._interstitialAd = null;
                },
                onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
              );
            },
            onAdFailedToLoad: (LoadAdError error) =>
                print('Interstitial failed to load: $error')));
  }

  Future getData() async {
    isLoading = true;
    storyData = await StoryDetailScreenService(
            storyID: widget.storyID, chapterNumber: currentChapterNumber)
        .getChapterData();

    // debugPrint("story to store ${this.storyToStore}", wrapWidth: 1024);

    setState(() {
      visible = false;
      isLoading = false;

      chapterTitle = storyData["title"];
      chapterContent = storyData["content"];

      var dataToStore = storyData;
      dataToStore["currentChapterNumber"] = currentChapterNumber;

      // debugPrint("story data to store : ${this.storyToStore}", wrapWidth: 1024);
    });
    await getStoryDataToStore();
    // print("story author ${this.storyToStore["author"]}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: visible
            ? AppBar(
                backgroundColor: Colors.white,
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    new TextSpan(
                        text: widget.storyTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print("close reading screen with $currentChapterNumber");
                      Navigator.pop(context, this.currentChapterNumber);
                    }),
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        print("user clicks to refresh");
                        setState(() {
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.blue,
                      ))
                ],
              )
            : null,
        backgroundColor: Colors.white,
        persistentFooterButtons: visible
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: currentChapterNumber == 1? null :  () {
                        print("user wants to go back");
                        setState(() {
                          currentChapterNumber--;
                          if(this.currentChapterNumber % 3 == 0 && this.currentChapterNumber != 1){
                            print("this divides 3 and will show ad now");
                            this._interstitialAd.show();
                            loadInterstitialAd();

                          }
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: currentChapterNumber == 1
                            ? Colors.grey[300]
                            : Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          enableDrag: true,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: MediaQuery.of(context).size.height * 0.95,
                              child: MenuChapters(
                                storyTitle: widget.storyTitle,
                                storyID: widget.storyID,
                                currentChapter: widget.currentChapterNumber,
                                chaptersCount: widget.chaptersCount,
                                isFavorite: widget.isFavorite,
                                fromReading: true,
                              ),
                            );
                          },
                        ).then((chosenChapterNumber) {
                          if (chosenChapterNumber != null) {
                            setState(() {
                              this.currentChapterNumber = chosenChapterNumber;
                              getData();
                            });
                          }
                        });
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: currentChapterNumber == widget.chaptersCount? null : () {
                        setState(() {
                          currentChapterNumber++;
                          print("user wants to read next with chapter $currentChapterNumber");

                          if(this.currentChapterNumber % 3 == 0){
                            print("this divides 3 and will show ad now");
                            this._interstitialAd.show();
                            loadInterstitialAd();

                          }
                          getData();
                        });
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: currentChapterNumber == widget.chaptersCount
                            ? Colors.grey[300]
                            : Colors.blue,
                      ),
                    ),
                  ],
                )
              ]
            : null,
        body: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Đang tải...",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    print("show/hide navbar");
                    this.visible = !this.visible;
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: visible ? 0 : 56,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                chapterTitle,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Html(data: chapterContent, style: {
                              "body": Style(
                                  color: Colors.black,
                                  fontSize: FontSize.rem(1.15))
                            }),
                            Container(
                              margin: EdgeInsets.only(bottom: 50, top: 20),
                              child: Center(
                                child: Text(
                                  "--- $currentChapterNumber "
                                  "/ ${widget.chaptersCount} ---",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
