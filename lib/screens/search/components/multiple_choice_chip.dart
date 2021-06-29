import 'package:flutter/material.dart';

class MultipleChoiceChip extends StatefulWidget {
  final List<String> list;
  final Function(List<String>) onSelectChange;

  MultipleChoiceChip(this.list, {required this.onSelectChange});

  @override
  _MultipleChoiceChipState createState() => _MultipleChoiceChipState();
}

class _MultipleChoiceChipState extends State<MultipleChoiceChip> {
  List<String> selectedChoices = [];

  List<Widget> _buildChoiceList() {
    List<Widget> choices = []; // render all the chipchoice widgets

    for (int i = 0; i < widget.list.length; i++) {
      var currentItemLabel = widget.list[i];
      var newItem = Container(
        // padding: EdgeInsets.all(2.0),
        padding: EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 0.0),
        child: ChoiceChip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          selectedColor: Colors.blue,
          // disabledColor: Color(0xFFF0F0F0).withOpacity(0.5),
          disabledColor: Colors.black,
          // didn't change
          label: Text(
            currentItemLabel,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15.0),
          ),
          selected: selectedChoices.contains(currentItemLabel),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(currentItemLabel)
                  ? selectedChoices.remove(currentItemLabel)
                  : selectedChoices.add(currentItemLabel);
              widget.onSelectChange(selectedChoices);
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
