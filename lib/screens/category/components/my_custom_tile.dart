import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../../constants.dart';

class MyCustomTile extends StatelessWidget {
  MyCustomTile({Key? key, required this.currentItemData}) : super(key: key);

  Map currentItemData;

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
      padding: EdgeInsets.all(5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                // height: 80,
                // width: 60,
                height: 130,
                // width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: currentItemData["cover"],
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return SkeletonAnimation(
                          child: Container(
                        height: 130,
                        width: 93,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      currentItemData["title"],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          color: Colors.blue),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(
                      "Hôm qua",
                      style: kSubTittleBiggerTextStyle,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      currentItemData["author"],
                      style: kSubTittleBiggerTextStyle,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      "${currentItemData["chapter_count"]} chương",
                      style: kSubTittleBiggerTextStyle,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    // Text(
                    //   "Ngôn Tình - Hài Hước - Kiếm Hiệp",
                    //   style: kSubTitleTextStyle,
                    // ),
                    RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style: TextStyle(),
                            children: renderGenreWidget(
                                genreList: currentItemData["genre"])))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
