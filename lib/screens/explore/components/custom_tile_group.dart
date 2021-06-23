import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/story_info.dart';
import 'package:reading_app/utilities/time.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../constants.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({Key? key, required this.currentItem}) : super(key: key);

  final Map currentItem;

  List<TextSpan> renderGenreWidget({required List genreList}) {
    List<TextSpan> list = [];
    for (var i = 0; i < genreList.length; i++) {
      var currentItem = genreList[i];

      var newWidget =
          new TextSpan(style: kSubTittleBiggerTextStyle, text: currentItem);

      list.add(newWidget);

      list.add(TextSpan(
        text: " . ",
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
      child: GestureDetector(
        onTap: () {
          print("tap group item ${currentItem["_id"]["\$oid"]}");

          pushNewScreen(context,
              screen: StoryInfo(storyID: currentItem["_id"]["\$oid"]),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(children: [
                        TextSpan(
                            text: currentItem["title"],
                            style: kTitleBlue500TextStyle)
                      ])),
                  SizedBox(
                    height: 7.5,
                  ),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(children: [
                        new TextSpan(
                            text: Time().getDate(currentItem["updated"]),
                            style: kSubTittleBiggerTextStyle)
                      ])),
                  SizedBox(
                    height: 3,
                  ),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(children: [
                        new TextSpan(
                            text: currentItem["author"],
                            style: kSubTittleBiggerTextStyle)
                      ])),
                  SizedBox(
                    height: 3,
                  ),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(children: [
                        new TextSpan(
                            text: "${currentItem["chapter_count"]} chương",
                            style: kSubTittleBiggerTextStyle)
                      ])),
                  SizedBox(
                    height: 3,
                  ),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      text: TextSpan(
                          children: renderGenreWidget(
                              genreList: currentItem["genre"]))),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                    imageUrl: currentItem["cover"],
                    height: 120,
                    width: 90,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        SkeletonAnimation(
                          child: Container(
                            height: 120,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300]),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
