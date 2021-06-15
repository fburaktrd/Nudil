import 'database.dart';

class User {
  final String uid;
  String displayName;
  List<String> friends;
  User({this.uid}) {
    initiliaze(uid);
  }

  initiliaze(String uid) async {
    await getDisplayNameFromFirebase(uid);
    await getFriends(displayName);
  }

  getDisplayNameFromFirebase(String uid) async {
    displayName = await DataBaseConnection.getUserDisplayName(uid);
  }

  getFriends(String displayName) async {
    friends = await DataBaseConnection.returnFriends(displayName);
    print(friends);
  }
}

class Events {
  final String userName;
  final String eventID;
  final String eventName;
  String aciklama;
  String yorumlar;
  Map katilan;
  Map tarihler;
  Events({this.eventID, this.userName, this.eventName}) {
    basla();
    print("evet");
  }
  basla() async {
    await setTarih();
    await setParticipants();
    await setAciklama();
    await setYorumlar();
    print(katilan);
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
