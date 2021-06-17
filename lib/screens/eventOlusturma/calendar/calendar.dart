import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import './Saat.dart';
import './saatSayiSec.dart';
import './saatState.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xff30374b), fontWeight: fontWeight);
  }

  Map sayiSec = new Map();
  List<DateTime> secililer = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              TableCalendar(
                focusedDay: selectedDay,
                firstDay: DateTime.now(),
                lastDay: DateTime(2100),
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  if (secililer.contains(focusDay)) {
                    print(sayiSec);
                    secililer.remove(focusDay);
                    sayiSec.remove(takvimFormat(focusDay));
                  } else {
                    //saat eklemeye gidilmesi durumunda başlangıç 1 olarak tanımlandı
                    sayiSec[takvimFormat(focusDay)] = 1;
                    secililer.add(focusDay);
                  }
                  secililer.sort();
                  selectedDay = focusDay;
                  setState(() {});
                },
                holidayPredicate: (day) {
                  if (secililer.contains(day)) {
                    return true;
                  }
                  return false;
                },
                enabledDayPredicate: (day) {
                  return true;
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                      color: Colors.grey[400], shape: BoxShape.circle),
                  todayTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  selectedTextStyle: TextStyle(color: Color(0xff30374b)),
                  outsideTextStyle:
                      TextStyle(color: Colors.grey[500], fontSize: 15),
                  weekendTextStyle:
                      TextStyle(color: Colors.red[800], fontSize: 15),
                ),

                ///////////////////////////
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Color(0xff30374b),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  weekendStyle: TextStyle(
                    color: Color(0xff30374b),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                headerStyle: HeaderStyle(
                    leftChevronIcon: Icon(Icons.arrow_back_ios,
                        size: 15, color: Colors.black),
                    rightChevronIcon: Icon(Icons.arrow_forward_ios,
                        size: 15, color: Colors.black),
                    titleTextStyle: GoogleFonts.montserrat(
                        color: Color(0xff30374b),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    titleCentered: true,
                    formatButtonVisible: false),
                //calendarFormat: _controller,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 6,
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        secililer.length,
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
                                      //width: 50,
                                      height: 50,
                                      color: Colors.transparent,
                                      child: Center(
                                          child: Text(takvimFormat(
                                              secililer.elementAt(index)))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: RawMaterialButton(
                                        child: Text(
                                            sayiSec[takvimFormat(
                                                    secililer.elementAt(index))]
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                color: Color.fromRGBO(
                                                    59, 57, 60, 1),
                                                fontSize: 13.1,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () async {
                                          int aralik = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SaatSayiSec()),
                                          );
                                          sayiSec[takvimFormat(
                                                  secililer.elementAt(index))] =
                                              aralik;
                                          print(aralik);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
              child: Text('Tamam',
                  style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(59, 57, 60, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                //saat bilgileri olmayan tarihler dönüyor
                Map don = tarihSec(secililer);
                Navigator.pop(context, don);
                print(secililer);
              }),
          SizedBox(
            width: 20,
          ),
          RawMaterialButton(
            child: Text('Saat Ekle',
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              print(sayiSec);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Saat(
                            tarih: sayiSec,
                          )));
              SaatSec.siradakiId = 0;
            },
          ),
        ],
      ),
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

Map tarihSec(List<DateTime> x) {
  Map tarihler = new Map();
  for (int i = 0; i < x.length; i++) {
    tarihler[(i + 1) * 10] = {
      "tarih": takvimFormat(x.elementAt(i)),
      "baslangic": "",
      "bitis": ""
    };
  }

  return tarihler;
}
