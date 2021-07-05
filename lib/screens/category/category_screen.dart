import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import "package:reading_app/extensions.dart";
import 'package:reading_app/screens/category/category_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({required this.fromOtherRoute});

  final bool fromOtherRoute;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categoryList = [
    "Ngôn Tình",
    "Ngược",
    "Đam Mỹ",
    "Hài Hước",
    "Đô Thị",
    "Xuyên Không",
    "Xuyên Nhanh",
    "Truyện Teen",
    "Kiếm Hiệp",
    "Tiên Hiệp",
    "Sắc",
    "Sủng",
    "Mạt Thế",
    "Bách Hợp",
    "Đông Phương",
    "Cung Đấu",
    "Gia Đấu",
    "Cổ Đại",
    "Điền Văn",
    "Nữ Cường",
    "Nữ Phụ",
    "Trinh Thám",
    "Quan Trường",
    "Dị Năng",
    "Dị Giới",
    "Võng Du",
    "Linh Dị",
    "Trọng Sinh",
    "Quân Sự",
    "Lịch Sử",
    "Thám Hiểm",
    "Huyền Huyễn",
    "Khoa Huyễn",
    "Hệ Thống",
    "Tiểu Thuyết",
    "Phương Tây",
    "Việt Nam",
    "Đoản Văn",
    "Khác",
  ];

  List<Widget> renderCategoryWidget() {
    List<Widget> list = [];

    for (int index = 0; index < categoryList.length; index++) {
      var category = categoryList[index];
      var newItem = GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, "/categoryDetail");
            print("user chose this one $category");
            pushNewScreen(
              context,
              screen: CategoryDetailScreen(
                selectedGenre: category,
              ),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 0,
            child: Center(
                child: Text(
              category.capitalize(),
              style: TextStyle(color: Colors.black, fontSize: 15),
            )),
          ));

      list.add(newItem);
    }

    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("from other route? ${widget.fromOtherRoute}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Thể loại',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: widget.fromOtherRoute
              ? BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                )
              : null,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return true;
          },
          child: Scrollbar(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(bottom: 15.0),
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                childAspectRatio: 3.7,
                children: renderCategoryWidget(),
              ),
            ),
          ),
        ));
  }
}
