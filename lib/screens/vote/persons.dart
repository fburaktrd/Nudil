import 'package:flutter/material.dart';

const double personCellWith = 87.5;
const double personCellHeight = 79;

class Persons extends StatelessWidget {
  final String name;
  final String id;
  final Color color;
  final Image pp;

  Persons({
    this.pp,
    this.id,
    this.color,
    this.name,
  });

//Map<>
  @override
  Widget build(BuildContext context) {
    return Container(
      width: personCellWith,
      height: personCellHeight,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: color,
          border: Border.all(
            color: Colors.black12,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(4)),
      alignment: Alignment.center,
      child: Text(
        '${id ?? ''}',
        style: TextStyle(
            fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
