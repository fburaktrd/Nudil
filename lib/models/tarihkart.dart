import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/planlama.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_first_app/services/auth.dart';

import 'oyOncesi.dart';

class TarihKart extends StatefulWidget {
  @override
  _TarihKartState createState() => _TarihKartState();
}

class _TarihKartState extends State<TarihKart> {
  final AuthService _auth = AuthService();

  int sayi = 0;
  List<Widget> olustur = [];
  Future<void> setSayi() async {
    sayi = await DataBaseConnection.eventLength("Burak");
    setState(() {
      olustur = listeYapici(sayi, context);
    });
  }

  @override
  void initState() {
    super.initState();
    setSayi();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('our_app_name'),
          backgroundColor:Color(0xff651fff),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
      body: Container(
        decoration: BoxDecoration(),
        child: GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          childAspectRatio: .75,
          children: olustur,
        ),
      ),
      floatingActionButton: RawMaterialButton(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff651fff),
            borderRadius: BorderRadius.circular(7.31),
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

List<Widget> listeYapici(int sayi, BuildContext context) {
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
            return OyOncesi();
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
          "title $i",
          style: TextStyle(fontSize: 30, color: Colors.white),
        )),
      ),
    );
    liste.add(a);
  }

  return liste;
}
