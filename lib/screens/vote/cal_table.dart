import 'package:flutter/material.dart';

const double calCellWidth = 80;
const double calCellHeight = 100;

class CalTable extends StatelessWidget {
  final String tarihler; //final int tarihler
  final Color color;
  final String index;
  // final String oylanmisTarih;//01.06.21 de eklendi silinebilir

  CalTable({
    this.tarihler,
    this.color,
    this.index,
    // this.oylanmisTarih,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: calCellWidth,
      height: calCellHeight,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: color,
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4)),
      alignment: Alignment.center,
      child: Text(
        '$index',
        style: TextStyle(
            fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
