import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/apbar/apbar.dart';
import 'package:flutter_first_app/screens/vote/multiplication_table.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'user.dart';

class OyOncesi extends StatefulWidget {
 
  String eventID;
  final Events event;
  OyOncesi({this.eventID,this.event});

  @override
  _OyOncesiState createState() => _OyOncesiState();
}

class _OyOncesiState extends State<OyOncesi> {
  final AuthService _auth = AuthService();
  String userName = "";
  String ab;
  TextEditingController textController2;
  String instruction = "";
  String comments = "";
  Map dates = {};
  Map katilanlar = {};
  setBilgiler() {
    katilanlar = widget.event.katilan;
    
    userName = widget.event.userName;
    
    dates = widget.event.tarihler;
    instruction = widget.event.aciklama;
    comments = widget.event.yorumlar;
    
  }

  @override
  void initState() {
    super.initState();
    setBilgiler();

    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    textController2.dispose();
    super.dispose();
  }

  PageController x = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apbar(context: context, widget: widget).x(),
      body: SafeArea(
        child: 
          PageView(
            controller: x,
            children: [
              ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff30374b),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(11),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Text(
                          "         ${widget.event.eventName}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        RawMaterialButton(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Oylamaya Git",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(Icons.arrow_right_outlined,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                            onPressed: () {
                              x.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeOut);
                            }),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.7,
                          child: Column(
                            children: [
                              Container(
                                  child: Text("Açıklama",
                                      style: TextStyle(color: Colors.white)),
                                  padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xff30374b),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(12)))),
                              Text(
                                "$instruction",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Column(
                            children: [
                              Container(
                                  child: Text(
                                    "Yorumlar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  padding: EdgeInsets.fromLTRB(32, 0, 32, 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xff30374b),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(12)))),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 4, 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.all(0),
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      "$comments",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: textController2,
                                maxLines: 1,
                                onSubmitted: (String s) {
                                  DataBaseConnection.setComments(
                                      userName, widget.eventID, s);
                                  print(dates);
                                  //debugPrint("yazildi: $value");
                                  textController2.clear();
                                  RestartWidget.restartApp(context);
                                },
                                //debugPrint("yazildi: $s");
                                //onEditingComplete: () {
                                //  DataBaseConnection.setComments(userName, widget.eventID, _comment);
                                //},
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Yorum yap",
                                  suffixIcon: Icon(Icons.arrow_right),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MultiplicationTable(
                user: userName,
                event:widget.event
              ) 
            ],
         
        
        
      )
      )
    );
  
    
  }
}
