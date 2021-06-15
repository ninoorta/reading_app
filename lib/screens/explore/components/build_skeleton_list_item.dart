import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class BuildSkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonAnimation(
          child: Container(
            margin: EdgeInsets.only(right: 5.0),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SkeletonAnimation(
          child: Container(
            height: 12,
            width: 100,
            margin: EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3.0)),
            padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
          ),
        ),
      ],
    );
  }
}
