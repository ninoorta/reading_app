import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'build_list_item.dart';
import 'build_skeleton_list_item.dart';

class CustomListView extends StatelessWidget {
  CustomListView({
    Key? key,
    required this.isLoading,
    required this.listName,
    required this.listData,
  }) : super(key: key);

  final bool isLoading;
  final String listName;
  List listData;

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
          height: 180.0,
          width: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: isLoading ? 10 : listData.length,
            itemBuilder: (context, index) {
              return isLoading
                  ? BuildSkeletonItem()
                  : BuildListItem(
                      item: listData[index],
                    );
            },
          ),
        )
      ],
    );
  }
}
