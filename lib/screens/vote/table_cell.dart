import 'package:flutter/material.dart';

const double cellWidth = 80;
const double cellHeight = 75;

class MultiplicationTableCell extends StatefulWidget {
  final String value;
  final Color color;
  final int index;
  bool isChecked;
  VoidCallback removeFromList;
  VoidCallback addList;

  MultiplicationTableCell({
    this.value,
    this.color,
    this.index,
    this.isChecked,
    this.addList,
    this.removeFromList,
  });

  @override
  Hucre createState() => Hucre();
}

class Hucre extends State<MultiplicationTableCell> {
  @override
  Widget build(BuildContext context) {
    if (widget.value == "0") {
      return Container(
        width: cellWidth,
        height: cellHeight,
        decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(
              color: Colors.black12,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Container(
          child: Checkbox(
            //checkColor: Colors.blue[600],
            activeColor: Colors.cyan,
            value: widget.isChecked,
            onChanged: (x) {
              if (x) {
                widget.addList();
              } else {
                widget.removeFromList();
              }
              widget.isChecked = x;
            },
          ),
        ),
      );
    } else {
      return Container(
        width: cellWidth,
        height: cellWidth,
        decoration: BoxDecoration(
            color: widget.color,
            border: Border.all(
              color: Colors.black12,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Container(
          child: Checkbox(
            onChanged: (x) {},
            //checkColor: Colors.blue,
            value: widget.isChecked,
          ),
        ),
      );
    }
  }
}
