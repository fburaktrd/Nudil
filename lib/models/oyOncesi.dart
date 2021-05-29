import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OyOncesi extends StatefulWidget {
  @override
  _OyOncesiState createState() => _OyOncesiState();
}

class _OyOncesiState extends State<OyOncesi> {
  String _comment = "";
  TextEditingController textController2;

  @override
  void initState() {
    super.initState();

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
                "Event Name",
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
                      "Description Field",
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
                    child: TextField(
                      controller: textController2,
                      maxLines: 20,
                      onChanged: (value) {
                        _comment = value;
                        debugPrint("yazildi: $value");
                      },
                      //debugPrint("yazildi: $s");
                      onEditingComplete: () {},
                      decoration: InputDecoration(
                        hintText: "Comment",
                        suffixIcon: Icon(Icons.arrow_right),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("Vote"),
        backgroundColor: Color(0xff651fff),
      ),
    );
  }
}
