import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/planlama.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'oyOncesi.dart';
import 'package:flutter_first_app/screens/apbar/apbar.dart';

class TarihKart extends StatefulWidget {
  @override
  _TarihKartState createState() => _TarihKartState();
}

class _TarihKartState extends State<TarihKart> {
  List<String> titles = [];
  List<Widget> olustur = [];
  List<String> eventNames = [];
  int sayi = 0;
  final AuthService _auth = AuthService();
  String userName = "";
  static String temp = "";
  Future<void> setBilgiler() async {
    String uid = await _auth.getUseruid();
    print(uid);
    userName = await DataBaseConnection.getUserDisplayName(uid);
    print("yazıyorum");
    print(userName);
    eventNames = await DataBaseConnection.getEventNames(userName);
    sayi = await DataBaseConnection.eventLength(userName);
    titles = await DataBaseConnection.getEventTitles(eventNames);
    print(this.mounted);
    if (this.mounted) {
      setState(() {
        olustur = listeYapici(sayi, titles, eventNames, context);
      });
    } 
    
  }

  @override
  void initState() {
    titles.clear();
    super.initState();
    setBilgiler();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apbar(context: context, widget: widget).x(),
      body: NotificationListener<OverscrollNotification>(
        onNotification: (x) {
          if (x.overscroll < -5) {
            RestartWidget.restartApp(context);
          }
          return true;
        },
        child: Container(
          decoration: BoxDecoration(),
          child: GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            children: olustur,
          ),
        ),
      ),
      floatingActionButton: RawMaterialButton(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff30374b),
            borderRadius: BorderRadius.circular(7.30),
          ),
          padding: EdgeInsets.all(8),
          child: Text('Planlama',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Planlama())),
      ),
    );
  }
}

List<Widget> listeYapici(
    int sayi, List<String> deneme, List<String> eventID, BuildContext context) {
  bool tek = false;
  List<Widget> liste = [];
  //faik event sayisi
  for (int i = 0; i < sayi; i++) {
    String x = i.toString();
    Widget a = GestureDetector(
      onTap: () {
        tek = !tek;
      },
      onDoubleTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return RestartWidget(
                child: OyOncesi(eventName: deneme[i], eventID: eventID[i]));
          },
        ) //        Grup(i: x),

            );
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.31),
          color: Color(0xff30374b),
        ),
        child: Container(
            child: Text(
          deneme[i],
          style: TextStyle(fontSize: 30, color: Colors.white),
        )),
      ),
    );
    liste.add(a);
  }

  return liste;
}
