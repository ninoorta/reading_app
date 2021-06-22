import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class BuildSkeletonItem extends StatelessWidget {
  final double width;
  final double height;

  BuildSkeletonItem({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.grey[300]),
      width: width,
      height: height,
    ));
  }
}
