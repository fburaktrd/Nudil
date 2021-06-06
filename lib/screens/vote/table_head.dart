import 'package:flutter/material.dart';

import 'cal_table.dart';
import 'persons.dart';



class TableHead extends StatelessWidget {
  final ScrollController scrollController;
  List<String> tarihListesi;
  TableHead({@required this.scrollController, this.tarihListesi});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Row(
        children: [
          Persons(color: Colors.deepPurple[800] //Color(0xff651fff),
              //value: 1,
              ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: tarihListesi.length,
              itemBuilder: (context, index) {
                return CalTable(
                  color: Color(0xff30374b),
                  tarihler: (tarihListesi[index]),
                  index: tarihListesi[index].toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
