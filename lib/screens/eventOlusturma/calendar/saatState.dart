import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class SaatSec extends StatefulWidget {
  //oluşan saat seçme widgetlarının sayısını tutmak ve bunların mapte kullanılması için static değişken tanımlandı
  static int siradakiId = 10;
  int id = siradakiId+=10;
  
  final Map tarihler;
  final String tarihString;
  SaatSec({this.tarihler, this.tarihString});
  @override
  SaatSecme createState() => SaatSecme();
}

class SaatSecme extends State<SaatSec> {
  
  TimeOfDay now = TimeOfDay.now();
  TimeOfDay sec = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay basAyar = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay bitirAyar = TimeOfDay(hour: 12, minute: 0);
  @override
  void initState(){
    //değer girilmese dahi indise değerler tanımlanıyor
    widget.tarihler[widget.id] = {
      "tarih": widget.tarihString,
      "baslangic": "",
      "bitis": ""
    };
    super.initState();
  }
  
  Widget build(BuildContext context) {
   
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              showPicker(
                  is24HrFormat: true,
                  iosStylePicker: true,
                  context: context,
                  value: basAyar,
                  onChange: (x) {
                    basAyar = x;
                    
                    
                    print(widget.tarihler[widget.tarihString]);
                    widget.tarihler[widget.id] = {
                        "tarih": widget.tarihString,
                        "baslangic": saatFormat(basAyar),
                        //bitiş saati başlangıç saatine eşit ise bitiş saati olarak "" dönüyor
                        "bitis": basAyar==bitirAyar?"":saatFormat(bitirAyar)
                    };
                    setState(() {});
                  }),
            );
          },
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.fromLTRB(4, 16, 4, 16),
            alignment: Alignment.center,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 4.5),
            color: Colors.grey[350].withAlpha(100),
            child: Text(
              "\n" + "baslangic\n" + saatFormat(basAyar),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                showPicker(
                    is24HrFormat: true,
                    iosStylePicker: true,
                    context: context,
                    value: bitirAyar,
                    onChange: (x) {
                      bitirAyar = x;
                      print(saatFormat(x));
                      //String samet = widget.id.toString();
                      widget.tarihler[widget.id] = {
                        "tarih": widget.tarihString,
                        "baslangic": saatFormat(basAyar),
                        "bitis": basAyar==bitirAyar?"":saatFormat(x),
                      };
                      print(widget.tarihler);
                      setState(() {});
                    }),
              );
            },
            child: Container(
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.fromLTRB(4, 16, 4, 16),
              alignment: Alignment.center,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 4.5),
              color: Colors.grey[350].withAlpha(100),
              child: Text(
                "\n" + "bitis\n" + saatFormat(bitirAyar),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            )),
      ],
    );
  }
}

String saatFormat(TimeOfDay saat) {
  String saat1 = saat.hour.toString();
  String dakka1 = saat.minute.toString();
  saat1 = saat1.length == 1 ? '0' + saat1 : saat1;
  dakka1 = dakka1.length == 1 ? '0' + dakka1 : dakka1;
  return saat1 + ":" + dakka1;
}
