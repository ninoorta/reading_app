import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class BuildSkeletonTypeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10.0)),
        // padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
      ),
    );
  }
}
