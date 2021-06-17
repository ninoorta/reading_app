import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/story_info.dart';

class BuildListItem extends StatelessWidget {
  Map item;

  BuildListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print("click to move to its story info.");

            pushNewScreen(context,
                screen: StoryInfo(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
          child: Container(
            margin: EdgeInsets.only(right: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[300]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              // child: Image(
              //   width: 90,
              //   height: 120,
              //   fit: BoxFit.cover,
              //   image: NetworkImage(item["cover"]),
              // ),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(child: CircularProgressIndicator());
                },
                imageUrl: "${item["cover"]}",
                fit: BoxFit.cover,
                width: 90,
                height: 120,
              ),
            ),
          ),
        ),
        Container(
          child: AutoSizeText(
            item["title"],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black),
            minFontSize: 14.0,
          ),
          height: 50,
          width: 100,
          padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
        )
      ],
    );
  }
}
