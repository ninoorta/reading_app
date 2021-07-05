import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/story_info.dart';
import 'package:skeleton_text/skeleton_text.dart';

class BuildListItem extends StatelessWidget {
  Map item;
  BuildListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("click to move to its story info.");

        pushNewScreen(context,
            screen: StoryInfo(
              storyID: item["_id"]["\$oid"],
              fromHistory: false,
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino);
      },
      child: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[300]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) {
                    return SkeletonAnimation(
                        child: Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0)),
                    ));
                  },
                  imageUrl: "${item["cover"]}",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 120,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 4, 5, 0),
              child: AutoSizeText(
                item["title"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
                minFontSize: 14.0,
              ),
              height: 50,
              width: 100,
              // margin: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
            )
          ],
        ),
      ),
    );
  }
}
