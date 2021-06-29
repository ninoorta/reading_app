import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {Key? key, required this.title, required this.titleValue})
      : super(key: key);

  final String title;
  final String titleValue;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: new TextSpan(children: [
      new TextSpan(text: "$title:  ", style: kMediumDarkerTitleTextStyle),
      new TextSpan(text: "$titleValue", style: kMediumDarkerTitleTextStyle),
    ]));
  }
}
