import 'dart:core';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/tarihkart.dart';

import './calendar.dart';

class BilgiAlma extends StatefulWidget {
  @override
  _BilgiAlmaState createState() => _BilgiAlmaState();
}

class _BilgiAlmaState extends State<BilgiAlma> {
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
      backgroundColor: Colors.grey[350],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            //TextField(),
            Row(
              children: [
                RawMaterialButton(
                  child: Text('Back',
                      style: TextStyle(
                          color: Color.fromRGBO(59, 57, 60, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TarihKart())),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  color: Colors.white70,
                  child: Text(
                    "Plan An Event",
                    style: TextStyle(
                      backgroundColor: Colors.white,
                      //color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                RawMaterialButton(
                    child: Text('Create',
                        style: TextStyle(
                            color: Color.fromRGBO(59, 57, 60, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {} //calendar(),
                    ),
              ],
            ),
            Padding(
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
            RawMaterialButton(
              splashColor: Colors.blueGrey,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Calendar())),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10)),
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
                                color: Color.fromRGBO(59, 57, 60, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.arrow_right,
                        ),
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 9,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
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
                                  child: Center(child: Text("Ay")),
                                )),
                                Expanded(
                                    child: Container(
                                  color: Colors.transparent,
                                  width: 300,
                                  height: 100,
                                  child: Center(child: Text("Ay'ın Kaçı")),
                                )),
                                Expanded(
                                    child: Container(
                                  color: Colors.transparent,
                                  width: 100,
                                  height: 100,
                                  child: Center(child: Text("Ay'ın Günü")),
                                )),
                                Expanded(
                                    child: Container(
                                  color: Colors.transparent,
                                  width: 50,
                                  height: 50,
                                  child: Center(child: Text("saat")),
                                )),
                              ],
                            ),
                          )),
                ),
              ),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              color: Colors.white,
            ),
            RawMaterialButton(
              splashColor: Colors.blueGrey,
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10)),
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
                                color: Color.fromRGBO(59, 57, 60, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.arrow_right,
                        ),
                      ],
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 9,
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
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
                                  Text("Puşt Samet"),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRI4SgXIgt34ujxBvmx1MIyxWCaHyy_jsPKA&usqp=CAU"),
                                  ),
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
            Padding(
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
          ],
        ),
      ),
    );
  }
}
