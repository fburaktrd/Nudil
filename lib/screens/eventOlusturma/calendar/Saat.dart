import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './planlama.dart';
import './saatState.dart';

class Saat extends StatefulWidget {
  static Map asd=new Map();
  @override
  Saat1 createState() => Saat1();
}

class Saat1 extends State<Saat> {
  List<Widget> saatSec(Map a) {
    List<Widget> donecek = [];
    var tarihler = a.keys.toList();

    for (int i = 0; i < tarihler.length; i++) {
      donecek.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(a[tarihler.elementAt(i)], (index) {
          return Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue[900],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text("${tarihler.elementAt(i)} $index"),
                ),
                //başlangıç
                SaatSec(
                  indis: index,
                  tarihler: a,
                  x: tarihler.elementAt(i),
                )
              ],
            ),
          );
        }),
      ));
    }

    return donecek;
  }

  @override
  Widget build(BuildContext context) {
    
    Map tarih = new Map();
    tarih["18 Mayıs"] = 2;

    tarih["19 Mayıs"] = 1;
    tarih["20 Mayıs"] = 2;
    tarih["10"] = 3;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: saatSec(tarih),
          ),
          RawMaterialButton(
            child: Text('Seçtik Bitti',
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            onPressed: ()  {
              SaatSec.siradakiId=0;
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => BilgiAlma()));
                
                },
          ),
        ]),
      )),
    );
  }
}
