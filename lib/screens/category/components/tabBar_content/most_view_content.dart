import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// services
import 'package:reading_app/services/category_detail_screen_service.dart';

import '../my_custom_tile.dart';
import '../my_custom_tile_skeleton.dart';

class MostViewContent extends StatefulWidget {
  MostViewContent({
    required this.selectedGenre,
    required this.sortType,
    required this.limitItem,
  });

  // List data;
  String selectedGenre;
  String sortType;
  int limitItem;

  @override
  _MostViewContentState createState() => _MostViewContentState();
}

class _MostViewContentState extends State<MostViewContent> {
  ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isLoading = true;
  int nextOffset = 0;

  List tabData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
    this.isLoadingMore = true;
    nextOffset = nextOffset + widget.limitItem;
    var apiResult = await CategoryDetailScreenService().getData(
        genre: widget.selectedGenre,
        offset: nextOffset,
        sortType: widget.sortType,
        limitItem: widget.limitItem);

    setState(() {
      tabData = tabData + apiResult;
      this.isLoadingMore = false;
    });
  }

  Future getData() async {
    // this.isLoading = true;
    var apiResult = await CategoryDetailScreenService().getData(
        genre: widget.selectedGenre,
        offset: nextOffset,
        sortType: widget.sortType,
        limitItem: widget.limitItem);

    setState(() {
      this.tabData = apiResult;
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return true;
      },
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: isLoading ? 10 : tabData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return isLoading
                        ? MyCustomTileSkeleton()
                        : MyCustomTile(
                            currentItemData: tabData[index],
                          );
                  },
                ),
              ),
              isLoadingMore
                  ? Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CupertinoActivityIndicator(
                            radius: 15,
                          ),
                          SizedBox(
                            height: 7.5,
                          ),
                          Text(
                            "??ang t???i...",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
