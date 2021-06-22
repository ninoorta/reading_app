import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'build_skeleton_item.dart';

class MyCustomTileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SkeletonAnimation(
                child: Container(
                  // margin: EdgeInsets.only(top: 5),
                  height: 130,
                  width: 93,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 18,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 14,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: 14,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    BuildSkeletonItem(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 14,
                    ),
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
