import 'package:flutter/material.dart';

class MenuChapters extends StatelessWidget {
  const MenuChapters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tên truyện",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: BackButton(
          color: Colors.blue,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            // padding: EdgeInsets.only(right: 15.0),
            onPressed: () => print("click refresh"),
            icon: Icon(
              Icons.refresh,
              color: Colors.blue,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.skip_previous_rounded,
                  size: 30,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                )),
            Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                "1/2",
                style: TextStyle(color: Colors.blue, fontSize: 22),
              )),
            ),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.skip_next_rounded,
                  size: 30,
                )),
          ],
        )
      ],
      body: Scrollbar(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(bottom: 20.0),
            // height: 500,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Chương ${index + 1}",
                          style: TextStyle(
                              color: Colors.grey[850],
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "3 Jun 2021",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    index == 19
                        ? Container()
                        : new Divider(
                            color: Colors.black54,
                            thickness: 0.75,
                          )
                  ],
                );
              },
            )),
      ),
    );
  }
}
