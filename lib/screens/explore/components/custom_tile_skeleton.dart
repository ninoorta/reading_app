import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CustomTileSkeleton extends StatelessWidget {
  const CustomTileSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
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
                SkeletonAnimation(
                    child: Container(
                  height: 16,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3)),
                )),
                SizedBox(
                  height: 8.5,
                ),
                SkeletonAnimation(
                    child: Container(
                  height: 12,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3)),
                )),
                SizedBox(
                  height: 6,
                ),
                SkeletonAnimation(
                    child: Container(
                  height: 12,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3)),
                )),
                SizedBox(
                  height: 6,
                ),
                SkeletonAnimation(
                    child: Container(
                  height: 12,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3)),
                )),
                SizedBox(
                  height: 6,
                ),
                SkeletonAnimation(
                    child: Container(
                  height: 12,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3)),
                )),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SkeletonAnimation(
              child: Container(
                height: 120,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
