import 'package:flutter/material.dart';
import 'package:reading_app/screens/category/category_detail_screen.dart';

class SingleChoiceChipForLink extends StatefulWidget {
  final List list;

  SingleChoiceChipForLink(this.list);

  @override
  _SingleChoiceChipForLinkState createState() =>
      _SingleChoiceChipForLinkState();
}

class _SingleChoiceChipForLinkState extends State<SingleChoiceChipForLink> {
  String selectedChoice = "";

  void initState() {
    super.initState();
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = []; // render all the chipchoice widgets

    for (int i = 0; i < widget.list.length; i++) {
      var currentItem = widget.list[i];
      var newItem = Container(
        // padding: EdgeInsets.all(2.0),
        padding: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 0.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CategoryDetailScreen(selectedGenre: currentItem);
              },
            ));
          },
          child: ChoiceChip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              selectedColor: Colors.blue,
              label: Text(
                currentItem,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0),
              ),
              selected: false,
              onSelected: null),
        ),
      );
      choices.add(newItem);
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 1.0,
      spacing: 0.0,
      children: _buildChoiceList(),
    );
  }
}
