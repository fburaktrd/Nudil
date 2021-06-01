import 'dart:math';

import 'package:flutter/material.dart';

import './listeButonu.dart';

class ArkadasListe extends StatefulWidget {
  List<Widget> friends = List.generate(100, (index) {
    Widget x = ListeButon(index: index);

    return x;
  });

  ArkListe createState() => ArkListe();
}

class ArkListe extends State<ArkadasListe> {
  List<Widget> asilListe = [];
  String search = '';

  @override
  void initState() {
    super.initState();
    asilListe = widget.friends;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> seciliWidget = [];
    List<dynamic> seciliArk = []; //user type

    for (int i = 0; i < asilListe.length; i++) {
      if (asilListe.cast<ListeButon>().elementAt(i).seci == true) {
        seciliWidget.add(Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.all(4),
          width: 50,
          height: 50,
          child: Text(
            "${asilListe.cast<ListeButon>().elementAt(i).index}",
            style: TextStyle(color: Colors.white),
          ),
        ));
        seciliArk.add(asilListe.cast<ListeButon>().elementAt(i).index);
      }
    }

    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment(0, -.85),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(100),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width / 1.22,
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (ad) {
                    search = ad;
                    setState(() {});
                  },
                ),
              ),
              GestureDetector(
                onVerticalDragCancel: () {
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.22,
                  height: MediaQuery.of(context).size.height / 1.44,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: search.length == 0
                        ? asilListe
                        : asilListe
                            .cast<ListeButon>()
                            .where((element) =>
                                element.index.toString().contains(search))
                            .toList(), //.length==0? databasedeki kayıtlı kullanıcılardan ara ekle

                    childAspectRatio: .8,
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, .75),
          child: Container(
            margin: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width / 1.33,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Row(
                  children: seciliWidget.length == 0
                      ? [
                          Transform.rotate(
                            angle: -2 * pi / 180,
                            child: Container(
                              height: 44,
                              width: 88,
                              color: Colors.amber,
                              child: Text("Ekleme yapılmadı"),
                            ),
                          ),
                        ]
                      : seciliWidget,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(.8, .85),
          child: GestureDetector(
            onTap: () {
              print(widget.friends);
              setState(() {});
            },
            child: Transform.rotate(
              angle: (-8 * pi) / 180,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8)),
                width: 70,
                height: 50,
                alignment: Alignment.center,
                child: Text("Bitti"),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
