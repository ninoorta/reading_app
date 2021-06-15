import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/story_info.dart';

class BuildListItem extends StatelessWidget {
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
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        Container(
          child: AutoSizeText(
            "This text is so longgggggggggggggggggggggggggggggggggggggggggggggggggggggggggg.",
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
