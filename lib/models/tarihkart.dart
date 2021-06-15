import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/planlama.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'oyOncesi.dart';
import 'user.dart';
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
  static String userName = "";
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
    olustur = listeYapici(sayi, titles, eventNames, context);
    
     
    
  }

  @override
  void initState() {
    
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Apbar(context: context, widget: widget).x(),
      body: NotificationListener<OverscrollNotification>(
        onNotification: (x) {
          if (x.overscroll < -5) {
            setState(() {
              
            });
          }
          return true;
        },
        child: FutureBuilder(
          future: setBilgiler(),
          builder:(context,snap) {
            if(snap.connectionState==ConnectionState.waiting){
              
              return Center(child: CircularProgressIndicator(strokeWidth: 2,backgroundColor: Colors.amber,));
            }
            else{return Container(
              decoration: BoxDecoration(),
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                children: olustur,
              ), 
            );}
          },
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
  
  List<Widget> liste = [];
  for (int i = 0; i < sayi; i++) {
    Events event=new Events(eventID:eventID.elementAt(i),eventName: deneme.elementAt(i));
    Widget a = GestureDetector(
      
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return OyOncesi(event:event);
          },
        ) 

            );
      },
      child: Card(
        
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 8,
        
        margin: EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: EdgeInsets.symmetric(vertical:12),
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom:4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xff30374b),
          ),
          child: Text(
          deneme[i],
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        ),
      ),
    );
    liste.add(a);
  }

  return liste;
}
