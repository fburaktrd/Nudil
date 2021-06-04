import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './saatState.dart';

class Saat extends StatefulWidget {
  Saat({this.tarih});
  Map tarih;

  @override
  Saat1 createState() => Saat1();
}

class Saat1 extends State<Saat> {
  List<Widget> saatSec(Map a) {
    //Map a={tarih:'saat aralığı sayısı'}
    List<Widget> donecek = [];
    var tarihler = a.keys.toList();
    //döngüde kullanmak için mapteki keyler listeye atılıyor
    for (int i = 0; i < tarihler.length; i++) {
      donecek.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(a[tarihler.elementAt(i)], (index) {//a[tarihler.elementAt(i)]=saat aralığı sayısı
          return Container(
            margin: EdgeInsets.fromLTRB(1, 5, 1, 5),
            padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.31),
              color: Color(0xff30374b),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(2, 0.25, 2, 0.25),
              padding: EdgeInsets.fromLTRB(2, 8, 5, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.31),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "${tarihler.elementAt(i)} ${SaatSec.siradakiId}",
                      style: TextStyle(
                          color: Color(0xff30374b),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SaatSec(
                    tarihler: a,//oluşan saat sec objesinin erişmesi için saat aralıklarını tutan map ekleniyor
                    tarihString: tarihler.elementAt(i),
                  )
                ],
              ),
            ),
          );
        }),
      ));
      print(a[tarihler.elementAt(0)]);
    }
    //döngü bittikten sonra mapte gerek duyulmayan saat aralıkları temizleniyor
    a.clear();

    return donecek;
  }
  List<Widget> gunler = [];
  @override
  void initState() {
    //saat seçimi yapan widgetların listesi oluşturuluyor
    gunler = saatSec(widget.tarih);
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: gunler,
                    ),
                  ]),
            ),
            RawMaterialButton(
              child: Text('TAMAM',
                  style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(59, 57, 60, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
           
                //planlama sayfasına map döndürülüyor
                print(widget.tarih);
                print("asdadad");
                Navigator.of(context)..pop()..pop(widget.tarih);
              },
            ),
          ],
        ),
      )),
    );
  }
}

String takvimFormat(DateTime tarih) {
  String ay1 = tarih.month.toString();
  String gun1 = tarih.day.toString();
  String yil1 = tarih.year.toString();

  gun1 = gun1.length == 1 ? '0' + gun1 : gun1;
  ay1 = ay1.length == 1 ? '0' + ay1 : ay1;
  return gun1 + "." + ay1 + "." + yil1;
}
