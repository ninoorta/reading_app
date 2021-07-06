import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_custom_tile.dart';
import 'my_custom_tile_skeleton.dart';

class CustomTabBarContent extends StatelessWidget {
  const CustomTabBarContent({
    Key? key,
    required ScrollController scrollController,
    required this.categoryDetailData,
    required this.isLoading,
    required this.isLoadingMore,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List categoryDetailData;
  final bool isLoading;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryDetailData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var currentItem = categoryDetailData[index];
                  return isLoading
                      ? MyCustomTileSkeleton()
                      : MyCustomTile(
                          currentItemData: currentItem,
                          index: index,
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
                          "Đang tải...",
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
    );
  }
}
