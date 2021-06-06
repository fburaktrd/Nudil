import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/vote/persons.dart';
import 'package:flutter_first_app/screens/vote/table_cell.dart';
import 'package:flutter_first_app/screens/vote/voters.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class TableBody extends StatefulWidget {
  final ScrollController scrollController;
  List<String> tarihListesi;
  List<List<String>> kisiListesi;

  //
  List<Voters> kisiler;

  //
  TableBody(
      {@required this.scrollController,
      this.tarihListesi,
      this.kisiListesi,
      this.kisiler});

  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  LinkedScrollControllerGroup _controllers;
  ScrollController _firstColumnController;
  ScrollController _restColumnsController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _firstColumnController = _controllers.addAndGet();
    _restColumnsController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _firstColumnController.dispose();
    _restColumnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: personCellWith,
          child: ListView.builder(
            controller: _firstColumnController,
            physics: ClampingScrollPhysics(),
            itemCount: widget.kisiler.length,
            itemBuilder: (context, index) {
              return Persons(
                color: Color(0xff30374b), //Colors.blue[800],
                id: widget.kisiler[index].name,
                //index
                //Buraya pp de gelecek
              );
            },
          ), //bni
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              width: (widget.tarihListesi.length) * cellWidth,
              child: ListView.builder(
                controller: _restColumnsController,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.kisiler.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: List.generate(
                      widget.tarihListesi.length,
                      (x) {
                        return MultiplicationTableCell(
                          color: Colors.white,
                          value: index.toString(),
                          index: index,
                          isChecked: widget.kisiler[index].tarihler
                              .contains(widget.tarihListesi[x]),
                          addList: () {
                            widget.kisiler[index].tarihler
                                .add(widget.tarihListesi[x]);
                            widget.kisiler[index].tarihler.sort();
                            setState(
                              () {
                                debugPrint(widget.kisiler[index].name
                                        .toString() +
                                    ": " +
                                    widget.kisiler[index].tarihler.toString());
                              },
                            );
                          },
                          removeFromList: () {
                            widget.kisiler[index].tarihler
                                .remove(widget.tarihListesi[x]);
                            setState(
                              () {
                                debugPrint(widget.kisiler[index].name
                                        .toString() +
                                    ": " +
                                    widget.kisiler[index].tarihler.toString());
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
