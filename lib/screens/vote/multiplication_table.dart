import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/vote/table_body.dart';
import 'package:flutter_first_app/screens/vote/table_head.dart';
import 'package:flutter_first_app/screens/vote/voters.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class MultiplicationTable extends StatefulWidget {
  final String eventId;
  final Map dates;
  final Map katilanlar;
  MultiplicationTable({this.eventId,this.dates,this.katilanlar});
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  LinkedScrollControllerGroup _controllers;
  ScrollController _headController;
  ScrollController _bodyController;
  List<String> tarihler=[];
  Map onaylanan={};
  String userName="";
  List<Voters> kisiler = [];
  final AuthService _auth = AuthService();

  Future<void> bilgiler()async{
    String uid =await _auth.getUseruid();
    print(uid);
    userName=await DataBaseConnection.getUserDisplayName(uid);

    for(String key in widget.dates.keys){
      tarihler.add(widget.dates[key]["tarih"]+" "+widget.dates[key]["baslangic"]+"-"+widget.dates[key]["bitis"]);
      print(tarihler);
    }
    var ben =new Voters(userName, widget.katilanlar[userName]);
    kisiler.add(ben);
    for(String eleman in widget.katilanlar.keys){
      if(eleman == userName){
        continue;
      }
      var kisi = new Voters(eleman,widget.katilanlar[eleman]);
      print("welrtyujkışo");
      kisi.tarihler;
      kisiler.add(kisi);
    }
    setState(() {

    });
  }

  //
  @override
  void initState() {
    super.initState();
    bilgiler();
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    setState(() {});
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
                  DataBaseConnection.setChoices(kisiler.elementAt(0).tarihler, widget.eventId, userName);
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
