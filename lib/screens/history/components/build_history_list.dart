import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/story_info.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../history_detail_screen.dart';

class BuildHistoryList extends StatefulWidget {
  BuildHistoryList(
      {Key? key, required this.title, this.data, required this.refreshFunc})
      : super(key: key);

  final String title;
  final List? data;
  final refreshFunc;

  @override
  _BuildHistoryListState createState() => _BuildHistoryListState();
}

class _BuildHistoryListState extends State<BuildHistoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  print("user clicks to see more");

                  var isDeleted = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return HistoryDetail(
                        type:
                            widget.title == "Đọc Gần Đây" ? "read" : "favorite",
                        isBlank: widget.data == null ? true : false);
                  }));

                  print("is Deleted $isDeleted");
                  if (isDeleted) {
                    print("should refresh");
                    widget.refreshFunc();
                  }
                },
                child: Container(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                print("user clicks to see more");
                var isDeleted = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return HistoryDetail(
                      type: widget.title == "Đọc Gần Đây" ? "read" : "favorite",
                      isBlank: widget.data == null ? true : false);
                }));
                print("is Deleted $isDeleted");
                if (isDeleted) {
                  print("should refresh");
                  widget.refreshFunc();
                }
              },
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 20,
            )
          ],
        ),
        widget.data == null
            ? Container()
            : Container(
                // height: 600,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.data!.length >= 8 ? 8 : widget.data!.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.45,
                    crossAxisSpacing: 10.0,
                    // mainAxisSpacing: 10.0
                  ),
                  itemBuilder: (context, index) {
                    var currentItem = widget.data![index];
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: currentItem["cover"],
                              width: 90,
                              height: 120,
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return SkeletonAnimation(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    width: 90,
                                    height: 120,
                                  ),
                                );
                              },
                            ),
                          ),
                          onTap: () {
                            pushNewScreen(context,
                                    screen: StoryInfo(
                                      storyID: currentItem["storyID"],
                                      fromHistory: true,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino)
                                .then((value) {
                              print("receive favorite value $value");

                              if (value != null) {
                                widget.refreshFunc();
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              new TextSpan(
                                  text: currentItem["title"],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ]),
                          ),
                          onTap: () {
                            pushNewScreen(context,
                                    screen: StoryInfo(
                                      storyID: currentItem["storyID"],
                                      fromHistory: true,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino)
                                .then((value) {
                              print("receive favorite value $value");
                              if (value != null) {
                                widget.refreshFunc();
                              }
                            });
                          },
                        )
                      ],
                    );
                  },
                ),
              )
      ],
    );
  }
}
