import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_first_app/models/database.dart';

class Events {
  final String userName;
  final String eventID;
  final String eventName;
  String creator;
  String aciklama;
  String yorumlar;
  bool status;
  Map katilan;
  Map tarihler;
  Events({this.eventID, this.userName, this.eventName, this.status}) {
    basla();
  }

  basla() async {
    await setTarih();
    await setParticipants();
    await setAciklama();
    await setYorumlar();
    await setCreator();
  }

  setCreator() async {
    this.creator = await DataBaseConnection.getCreator(eventID);
  }

  setTarih() async {
    this.tarihler = await DataBaseConnection.getChoices(eventID);
  }

  setParticipants() async {
    this.katilan = await DataBaseConnection.getParticipantMap(eventID);
  }

  setAciklama() async {
    this.aciklama = await DataBaseConnection.getEventDiscription(eventID);
  }

  setYorumlar() async {
    this.yorumlar = await DataBaseConnection.getComments(eventID);
  }

  setEventInstructionAfterDecide(Map tarih) {
    this.aciklama = this.aciklama +
        " " +
        "\nKararlaştırılan Gün ${tarih["tarih"]} de/da \nSaat ${tarih["baslangic"]}-${tarih["bitis"]} arası.";
    DataBaseConnection.setEventInstruction(this.aciklama, this.eventID);
  }
}
