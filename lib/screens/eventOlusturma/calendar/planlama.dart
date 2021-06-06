import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/tarihkart.dart';
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
  String userName="";
  Future<void> setUserName()async{
    String uid =await _auth.getUseruid();
    print(uid);
    userName=await DataBaseConnection.getUserDisplayName(uid);
    print("yazıyorum");
    print(userName);
    setState(() {

    });
  }
  @override

  void initState() {

    super.initState();
    //findUser();
    setUserName();
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
  List<String> arkadas = ["samet","ali","ibo","naim"];
  Map tarihler=new Map();
  List<String> arkadaslar=[];
  String title="";
  String instruction="";
  int tarihLength=0;
  int arkLength=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apbar(context: context,widget: widget).x(),
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
                onPressed: () => Navigator.pop(context),
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
                  onPressed: () {
                    //print(tarihler);
                    DataBaseConnection.createEvent(userName, tarihler, arkadaslar,title,instruction);
                    Navigator.pop(context);
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
                onSubmitted: (String s) {

                  //title

                  title=s;
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
            onPressed: () async {
              tarihler = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Calendar()));
              try{
                tarihLength=tarihler.keys.length;
              }catch(e){
                tarihLength=0;
              }   
              setState(() {});
              print(tarihler);
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
                      //dönen tarihler mapinin içindeki indislerin sayısı kadar oluşuyor
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
                                  child: Text(tarihler[index]["tarih"]),
                                )),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  // width: 300,
                                  //height: 109,
                                  child: Text(
                                    //saat eklenmediği zaman başlangıç ve bitiş değeri 0 dönüyor
                                    tarihler[index]["baslangic"]==""?"":"Başlangic: "+tarihler[index]["baslangic"],
                                   
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  //width: 100,
                                  //height: 109,
                                  child: Text(
                                    tarihler[index]["bitis"]==""?"":"Bitis: "+tarihler[index]["bitis"],
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
              //Seçilen arkadaşlar 
              arkadaslar= await Navigator.push(context,MaterialPageRoute(builder: (context) => ArkadasListe()));
              try{
                arkLength=arkadaslar.length;
              }catch(e){
                arkLength=0;
              }
              setState(() {
                
              });
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

                  instruction=s;
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
