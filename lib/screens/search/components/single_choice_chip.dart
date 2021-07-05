import 'package:flutter/material.dart';

class SingleChoiceChip extends StatefulWidget {
  final List<String> list;
  final Function(String) onSelectChange;

  SingleChoiceChip(this.list, {required this.onSelectChange});

  @override
  _SingleChoiceChipState createState() => _SingleChoiceChipState();
}

class _SingleChoiceChipState extends State<SingleChoiceChip> {
  String selectedChoice = "";

  void initState() {
    super.initState();

    selectedChoice =
        widget.list[0]; // first item of list is set as selected default
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = []; // render all the chipchoice widgets

    for (int i = 0; i < widget.list.length; i++) {
      var currentItem = widget.list[i];
      var newItem = Container(
        // padding: EdgeInsets.all(2.0),
        padding: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 0.0),
        child: ChoiceChip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          selectedColor: Colors.blue,
          label: Text(
            currentItem,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15.0),
          ),
          selected: selectedChoice == currentItem ? true : false,
          onSelected: (selected) {
            setState(() {
              selectedChoice = currentItem;
              widget.onSelectChange(selectedChoice);
            });
          },
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
