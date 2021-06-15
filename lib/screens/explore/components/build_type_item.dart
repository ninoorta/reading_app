import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildTypeItem extends StatelessWidget {
  const BuildTypeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10.0)),
      // padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello",
            style: TextStyle(
              color: CupertinoColors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
