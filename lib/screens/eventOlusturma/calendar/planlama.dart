import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/tarihkart.dart';
import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/screens/apbar/apbar.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/saatState.dart';
import 'package:flutter_first_app/screens/eventOlusturma/friendList/arkadasListe.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'package:provider/provider.dart';

import './calendar.dart';

class Planlama extends StatefulWidget {
  @override
  _PlanlamaState createState() => _PlanlamaState();
}

class _PlanlamaState extends State<Planlama> {
  final AuthService _auth = AuthService();
  TextEditingController baslik;
  TextEditingController aciklama;
  FocusNode _focusNode;
  int maxLine = 1;

  @override
  void initState() {
    super.initState();
    //findUser();

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

  Map tarihler = new Map();
  List<String> arkadaslar = [];
  String title = "";
  String instruction = "";
  int tarihLength = 0;
  int arkLength = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: Apbar(context: context, widget: widget).bar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          Row(
            children: [
              RawMaterialButton(
                child: Text('Geri',
                    style: TextStyle(
                        color: Color(0xff30374b),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(6, 5, 5, 6),
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                  child: Text(
                    "Etkinlik Planla",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              RawMaterialButton(
                  child: Text('Olu??tur',
                      style: TextStyle(
                          color: Color(0xff30374b),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    //print(tarihler);
                    DataBaseConnection.createEvent(user.displayName, tarihler,
                        arkadaslar, title, instruction);
                    final snackBar = SnackBar(
                        backgroundColor: Colors.lightBlue,
                        content: Text("$title isimli event olu??turuldu !",
                            style: TextStyle(fontSize: 20)));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    
                    Navigator.pop(context,true);
                  } //calendar(),
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
                onChanged: (String s) {
                  //title
                  setState(() => title = s);
                  debugPrint("on submit:$s");
                },
                decoration: InputDecoration(
                    hintText: "Ba??l??k Giriniz..",
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
            onPressed: () async {
              tarihler = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Calendar()));
              try {
                tarihLength = tarihler.keys.length;
              } catch (e) {
                tarihLength = 0;
              }
              setState(() {});
            },
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
                      Text('G??n Ekle',
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
              padding: EdgeInsets.all(12),
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
                      //d??nen tarihler mapinin i??indeki indislerin say??s?? kadar olu??uyor
                      tarihLength,
                      (index) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(7.31),
                            ),
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    child: Container(
                                  //width: 100,
                                  //height: 109,
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child:
                                      Text(tarihler[(index + 1) * 10]["tarih"]),
                                )),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  // width: 300,
                                  //height: 109,
                                  child: Text(
                                    //saat eklenmedi??i zaman ba??lang???? ve biti?? de??eri 0 d??n??yor
                                    tarihler[(index + 1) * 10]["baslangic"] ==
                                            ""
                                        ? ""
                                        : "Ba??langic: " +
                                            tarihler[(index + 1) * 10]
                                                ["baslangic"],
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  //width: 100,
                                  //height: 109,
                                  child: Text(
                                    tarihler[(index + 1) * 10]["bitis"] == ""
                                        ? ""
                                        : "Bitis: " +
                                            tarihler[(index + 1) * 10]["bitis"],
                                  ),
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
            onPressed: () async {
              //Se??ilen arkada??lar
              arkadaslar = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArkadasListe()));
              try {
                arkLength = arkadaslar.length;
              } catch (e) {
                arkLength = 0;
              }
              setState(() {});
            },
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
                      Text('Arkada?? Ekle',
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
                    arkLength,
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
                                  Text("${arkadaslar[index]}"),
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
                  //instruction

                  instruction = s;
                  debugPrint("on submit:$s");
                },
                decoration: InputDecoration(
                    hintText: "A????klama Giriniz..",
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
