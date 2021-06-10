import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/filter_screen.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tìm Truyện',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                // print("time when click move to filter screen ${DateTime.now()}");

                pushNewScreen(
                  context,
                  screen: FilterScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              icon: Icon(
                Icons.filter_list,
                color: Colors.blue,
              ))
        ],
      ),
      body: Scrollbar(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  focusNode: textFieldFocusNode,
                  decoration: InputDecoration(
                      hintText: "Nhập tên truyện hoặc tác giả",
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 18),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.5),
                        size: 25,
                      ),
                      filled: true,
                      fillColor: Colors.grey[250],
                      contentPadding: EdgeInsets.symmetric(vertical: 1),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      suffixIcon: textFieldFocusNode.hasFocus
                          ? Icon(Icons.cancel_outlined)
                          : null),
                ),
              ),
              // content with FutureBuilder

              // guide text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Text(
                          'Để tìm kiếm chính xác hơn, bạn cần thêm dấu nháy " " vào cụm từ tìm kiếm của mình.'),
                      padding: EdgeInsets.symmetric(horizontal: 75),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 75),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: FilterScreen(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Center(
                          child: Text(
                            "Tìm Với Bộ Lọc Truyện",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
