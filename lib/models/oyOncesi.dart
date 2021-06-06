import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/apbar/apbar.dart';
import 'package:flutter_first_app/screens/vote/multiplication_table.dart';
import 'package:flutter_first_app/services/auth.dart';

class OyOncesi extends StatefulWidget {
  final String eventName;
  final String eventID;
  OyOncesi({this.eventName, this.eventID});

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
  Future<void> setBilgiler() async {
    String uid = await _auth.getUseruid();
    print(uid);
    userName = await DataBaseConnection.getUserDisplayName(uid);

    instruction = await DataBaseConnection.getEventDiscription(widget.eventID);
    comments = await DataBaseConnection.getComments(widget.eventID);
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apbar(context: context, widget: widget).x(),
      body: SafeArea(
        child: ListView(
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
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 7.5,
              child: Text(
                "${widget.eventName}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
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
              height: MediaQuery.of(context).size.height / 1.25,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.7,
                      child: Text(
                        "$instruction",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
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
                            padding: EdgeInsets.fromLTRB(0, 4, 4, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(0),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            child: SingleChildScrollView(
                              child: Text(
                                "$comments",
                                style: TextStyle(
                                  fontSize: 16,
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
                              //debugPrint("yazildi: $value");
                              textController2.clear();
                              RestartWidget.restartApp(context);
                            },
                            //debugPrint("yazildi: $s");
                            //onEditingComplete: () {
                            //  DataBaseConnection.setComments(userName, widget.eventID, _comment);
                            //},
                            decoration: InputDecoration(
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MultiplicationTable()));
        },
        child: Text("Vote"),
        backgroundColor: Color(0xff651fff),
      ),
    );
  }
}
