import 'dart:core';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import './saatSec.dart';
import 'Saat.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _currentIntValue = 3;
  CalendarFormat format = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  int _currentValue = 3;
  TextStyle dayStyle(FontWeight fontWeight) {
    return TextStyle(color: Color(0xff30374b), fontWeight: fontWeight);
  }

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
                    secililer.remove(focusDay);
                  } else {
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
                                      width: 50,
                                      height: 50,
                                      color: Colors.transparent,
                                      child: Center(
                                          child: Text(
                                              "${secililer.elementAt(index)}")),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: RawMaterialButton(
                                        child: Text(
                                            'kaç saat aralığı sayısı seçilecek',
                                            style: GoogleFonts.montserrat(
                                                color: Color.fromRGBO(
                                                    59, 57, 60, 1),
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage())),
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
              child: Text('Done',
                  style: GoogleFonts.montserrat(
                      color: Color.fromRGBO(59, 57, 60, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.pop(context)),
          RawMaterialButton(
            child: Text('Add Clock',
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Saat())),
          ),
        ],
      ),
    );
  }
}
