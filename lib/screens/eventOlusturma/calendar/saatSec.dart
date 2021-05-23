import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Aralık Sayısı Seciniz'),
        ),
        body: _IntegerExample(),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Secilecek Saat Aralık Sayısını giriniz',
            style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentIntValue,
          minValue: 0,
          maxValue: 24,
          step: 1,
          haptics: true,
          onChanged: (value) => setState(() => _currentIntValue = value),
        ),
        Divider(color: Colors.grey, height: 32),
        SizedBox(height: 16),
        Text('Current int value: $_currentIntValue'),
        RawMaterialButton(
            child: Text('Thanks',
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.pop(context, _currentIntValue)),
      ],
    );
  }
}
