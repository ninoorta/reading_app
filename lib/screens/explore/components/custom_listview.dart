import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/explore/list_detail_screen.dart';

import '../../../constants.dart';
import 'build_list_item.dart';
import 'build_skeleton_list_item.dart';

class CustomListView extends StatefulWidget {
  CustomListView(
      {Key? key,
      required this.isLoading,
      required this.listName,
      required this.listData,
      required this.isNewPublish})
      : super(key: key);

  final bool isLoading;
  final String listName;
  List listData;
  final bool isNewPublish;

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  List newPublishData = [];
  List newUpdateData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if(){
    //
    // }
  }

  Future getNewPublishData() async {}

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
            Text(widget.listName, style: kListTitleTextStyle),
            TextButton(
                onPressed: () {
                  print("click see more");
                  pushNewScreen(context,
                      screen: ListDetailScreen(
                        listName: widget.listName,
                        isNewPublish: widget.isNewPublish ? true : false,
                      ),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino);
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
            itemCount: widget.isLoading ? 10 : widget.listData.length,
            itemBuilder: (context, index) {
              return widget.isLoading
                  ? BuildSkeletonItem()
                  : BuildListItem(
                      item: widget.listData[index],
                    );
            },
          ),
        )
      ],
    );
  }
}
