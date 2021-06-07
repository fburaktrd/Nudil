import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/vote/table_body.dart';
import 'package:flutter_first_app/screens/vote/table_head.dart';
import 'package:flutter_first_app/screens/vote/voters.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class MultiplicationTable extends StatefulWidget {
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  LinkedScrollControllerGroup _controllers;
  ScrollController _headController;
  ScrollController _bodyController;
  List<String> tarihler;

  //List<List<String>> kisiListesi;

  //
  List<Voters> kisiler = [];

  //
  @override
  void initState() {
    super.initState();
    tarihler = [
      "02.06.2021 16.00 - 18.00",
      "02.06.2021 19.00 - 21.00",
      "08.01.2020 19.00 - 21.00",
      "04.06.2021 21.00 - 24.45",
      "05.06.2021 18.45 - 21.30",
      "06.06.2021 16.00 - 18.00",
      "07.04.2021 19.00 - 21.00"
    ];

    Voters Ali = new Voters("125634877", "Ali İbrahim Çakır");
    Ali.tarihler = [];
    kisiler.add(Ali);
    Voters Ahmet = new Voters("125634877", "Ahmet Kılıç");
    Ahmet.tarihler = [
      "02.06.2021 19.00 - 21.00",
      "08.01.2020 19.00 - 21.00",
      "05.06.2021 18.45 - 21.30",
    ];
    kisiler.add(Ahmet);

    Voters Metin = new Voters("125634877", "Metin Çakır");
    Metin.tarihler = [
      "04.06.2021 21.00 - 24.45",
      "05.06.2021 18.45 - 21.30",
      "07.04.2021 19.00 - 21.00"
    ];
    kisiler.add(Metin);
    Voters Berkay = new Voters("125634877", "Berkay Çakır");
    Berkay.tarihler = [
      "02.06.2021 19.00 - 21.00",
      "02.06.2021 19.00 - 21.00",
      "06.06.2021 16.00 - 18.00",
      "08.01.2020 19.00 - 21.00",
      "09.01.2020 19.00 - 21.00",
    ];
    kisiler.add(Berkay);
    Voters Emine = new Voters("125634877", "Emine Çakır");
    Emine.tarihler = [
      "02.06.2021 19.00 - 21.00",
      "05.06.2021 18.45 - 21.30",
      "06.06.2021 16.00 - 18.00",
    ];
    kisiler.add(Emine);

    Voters Mehmet = new Voters("156877456", "asdhvasvdsagdvsadşashdas");
    Mehmet.tarihler = [
      "05.06.2021 18.45 - 21.30",
      "07.04.2021 19.00 - 21.00",
    ];
    kisiler.add(Mehmet);
    Voters Samet = new Voters("156877456", "Samet Toprak");
    Samet.tarihler = [
      "02.06.2021 16.00 - 18.00",
      "02.06.2021 19.00 - 21.00",
      "05.06.2021 18.45 - 21.30"
    ];
    kisiler.add(Samet);
    Voters Ibo = new Voters("156877456", "İbrahim Çınar");
    Ibo.tarihler = [
      "02.06.2021 16.00 - 18.00",
      "05.06.2021 18.45 - 21.30",
    ];
    kisiler.add(Ibo);
    Voters AslanMashadow = new Voters("156877456", "Aslan of Course");
    AslanMashadow.tarihler = [
      "02.06.2021 19.00 - 21.00",
      "05.06.2021 18.45 - 21.30",
    ];
    kisiler.add(AslanMashadow);
    //
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    setState(() {});
  }

  @override
  void dispose() {
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableHead(
              scrollController: _headController,
              tarihListesi: tarihler,
            ),
            Expanded(
              child: TableBody(
                scrollController: _bodyController,
                tarihListesi: tarihler,
                kisiler: kisiler,
              ),
            ),
            Container(
              color: Colors.deepPurple[800],
              height: 35,
              width: MediaQuery.of(context).size.width / 1,
              child: RawMaterialButton(
                child: Text(
                  "ONAYLA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context)..pop()..pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
