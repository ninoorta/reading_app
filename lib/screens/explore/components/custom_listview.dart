import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'build_list_item.dart';
import 'build_skeleton_list_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    Key? key,
    required this.isLoading,
    required this.listName,
  }) : super(key: key);

  final bool isLoading;
  final String listName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(listName, style: kListTitleTextStyle),
            TextButton(
                onPressed: () {
                  print("click see more");
                },
                child: Text(
                  "Xem thêm",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ))
          ],
        ),
        Container(
          height: 150.0,
          width: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return isLoading ? BuildSkeletonItem() : BuildListItem();
            },
          ),
        )
      ],
    );
  }
}
