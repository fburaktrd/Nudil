import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_first_app/models/database.dart';

class Events {
  final String userName;
  final String eventID;
  final String eventName;
  String creator;
  String aciklama;
  String yorumlar;
  bool status = true;
  Map katilan;
  Map tarihler;
  Events({this.eventID, this.userName, this.eventName}) {
    basla();
  }
  basla() async {
    await setTarih();
    await setParticipants();
    await setAciklama();
    await setYorumlar();
    await setCreator();
    await setStatus();
    print("Event class içerisi "+status.toString());
  }

  setCreator() async {
    this.creator = await DataBaseConnection.getCreator(eventID);
  }

  setStatus() async {
    status = await DataBaseConnection.getEventStatus(eventID);
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
}
