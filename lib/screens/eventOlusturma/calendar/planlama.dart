import 'dart:core';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/tarihkart.dart';

import './calendar.dart';
import 'saatState.dart';

class Planlama extends StatefulWidget {
  @override
  _PlanlamaState createState() => _PlanlamaState();
}

class _PlanlamaState extends State<Planlama> {
  TextEditingController baslik;
  TextEditingController aciklama;
  FocusNode _focusNode;
  int maxLine = 1;
  @override
  void initState() {
    super.initState();
    baslik = TextEditingController();
    aciklama = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          maxLine = 5;
        } else {
          maxLine = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    baslik.dispose();
    aciklama.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          Row(
            children: [
              RawMaterialButton(
                child: Text('Back',
                    style: TextStyle(
                        color: Color(0xff30374b),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TarihKart())),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(6, 5, 5, 6),
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                  child: Text(
                    "Plan An Event",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              RawMaterialButton(
                  child: Text('Create',
                      style: TextStyle(
                          color: Color(0xff30374b),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {} //calendar(),
                  ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(.5, 5, .5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.31),
              color: Color(0xff30374b),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: baslik,
                onSubmitted: (String s) {
                  debugPrint("on submit:$s");
                },
                decoration: InputDecoration(
                    hintText: "Enter title",
                    suffixIcon: Icon(Icons.arrow_right),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
          ),
          RawMaterialButton(
            splashColor: Colors.blueGrey,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Calendar())),
            child: Container(
              margin: EdgeInsets.fromLTRB(.5, 5, .5, 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today_rounded),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Add Day',
                          style: TextStyle(
                              color: Color(0xff30374b),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(.5, 5, .5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.31),
              color: Color(0xff30374b),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
            child: Container(
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.31),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      SaatSec.siradakiId,
                      (index) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(7.31),
                            ),
                            margin: EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 109,
                                  color: Colors.transparent,
                                  child: Center(
                                      child: Text(
                                    "Ay",
                                  )),
                                )),
                                Expanded(
                                    child: Container(
                                  color: Colors.transparent,
                                  width: 300,
                                  height: 109,
                                  child: Center(
                                      child: Text(
                                    "Ay'ın Kaçı",
                                  )),
                                )),
                                Expanded(
                                    child: Container(
                                  color: Colors.transparent,
                                  width: 100,
                                  height: 109,
                                  child: Center(
                                      child: Text(
                                    "Ay'ın Günü",
                                  )),
                                )),
                                Expanded(
                                    child: Container(
                                  color: Colors.transparent,
                                  width: 100,
                                  height: 109,
                                  child: Center(
                                      child: Text(
                                    "saat",
                                  )),
                                )),
                              ],
                            ),
                          )),
                ),
              ),
            ),
          ),
          RawMaterialButton(
            splashColor: Colors.blueGrey,
            onPressed: () {},
            child: Container(
              margin: EdgeInsets.fromLTRB(.5, 5, .5, 5),
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.people_rounded),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Add Friend',
                          style: TextStyle(
                              color: Color(0xff30374b),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(.5, 5, .5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.31),
              color: Color(0xff30374b),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    10,
                    (index) => Container(
                      decoration: BoxDecoration(
                          backgroundBlendMode: BlendMode.darken,
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(4),
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRI4SgXIgt34ujxBvmx1MIyxWCaHyy_jsPKA&usqp=CAU"),
                                  ),
                                  Text("Puşt Samet"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(.5, 5, .5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.31),
              color: Color(0xff30374b),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: aciklama,
                maxLines: maxLine,
                focusNode: _focusNode,
                onSubmitted: (String s) {
                  debugPrint("on submit:$s");
                },
                decoration: InputDecoration(
                    hintText: "Enter explanation",
                    suffixIcon: Icon(Icons.arrow_right),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
