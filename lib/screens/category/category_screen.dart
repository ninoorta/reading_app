import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/category/category_detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({required this.fromOtherRoute});

  final bool fromOtherRoute;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> categoryList = [
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
    "Hài hước",
  ];

  List<Widget> renderCategoryWidget() {
    List<Widget> list = [];

    for (int index = 0; index < categoryList.length; index++) {
      var category = categoryList[index];
      var newItem = GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, "/categoryDetail");
            pushNewScreen(
              context,
              screen: CategoryDetailScreen(),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Card(
            elevation: 3,
            child: Center(
                child: Text(
              category,
              style: TextStyle(color: Colors.black, fontSize: 15),
            )),
          ));

      list.add(newItem);

      // if (index == categoryList.length - 1 && categoryList.length % 2 == 1) {
      //   list.add(SizedBox(
      //     height: 20.0,
      //   ));
      //   list.add(
      //       SizedBox(
      //     height: 2.0,
      //   ));
      // }

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
        body: Scrollbar(
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
        ));
  }
}
