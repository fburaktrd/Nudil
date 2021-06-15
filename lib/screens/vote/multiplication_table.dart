import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/events.dart';
import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/screens/vote/table_body.dart';
import 'package:flutter_first_app/screens/vote/table_head.dart';
import 'package:flutter_first_app/screens/vote/voters.dart';

import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class MultiplicationTable extends StatefulWidget {
  final String user;

  final Events event;
  MultiplicationTable({this.user, this.event});
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  LinkedScrollControllerGroup _controllers;
  ScrollController _headController;
  ScrollController _bodyController;
  List<String> tarihler = [];
  Map onaylanan = {};
  //String userName="";
  List<Voters> kisiler = [];

  bilgiler() {
    for (String key in widget.event.tarihler.keys) {
      tarihler.insert(
          0,
          widget.event.tarihler[key]["tarih"] +
              " " +
              widget.event.tarihler[key]["baslangic"] +
              "-" +
              widget.event.tarihler[key]["bitis"]);
      
    }

    var ben = new Voters(widget.user, widget.event.katilan[widget.user]);
      

    kisiler.add(ben);
    for (String eleman in widget.event.katilan.keys) {
      if (eleman == widget.user) {
        continue;
      }
      var kisi = new Voters(eleman, widget.event.katilan[eleman]);
      
      kisiler.add(kisi);
    }
  }

  //
  @override
  void initState() {
    super.initState();
    bilgiler();
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    print("object");
  }

  @override
  void dispose() {
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableHead(
              scrollController: _headController,
              tarihListesi: tarihler,
            ),
            Expanded(
              child: TableBody(
                scrollController: _bodyController,
                tarihListesi: tarihler,
                kisiler: kisiler,
              ),
            ),
            Container(
              color: Colors.deepPurple[800],
              height: 35,
              width: MediaQuery.of(context).size.width / 1,
              child: RawMaterialButton(
                child: Text(
                  "ONAYLA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                onPressed: () {
                  DataBaseConnection.setChoices(kisiler.elementAt(0).tarihler,
                      widget.event.eventID, widget.user);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
