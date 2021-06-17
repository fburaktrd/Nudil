import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_first_app/models/generate.dart';
import 'package:intl/intl.dart';

class DataBaseConnection {
  static final ref = FirebaseDatabase.instance.reference();
  static List<String> eventList = [];
  static List<String> eventTitle = [];

  static void setComments(String displayName, String eventId, String comment) {
    var now = new DateTime.now();
    String formattedTime = DateFormat('kk:mm').format(now);
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    ref
        .child("Comments")
        .child(eventId)
        .child(currentTime.toString())
        .set(formattedTime + " > " + displayName + ":" + comment);
  }

  static Future<String> getComments(String eventId) async {
    List<String> keys = [];
    String eventComment = "";
    DataSnapshot snap;
    snap = await ref.child("Comments").child(eventId).once();
    if (snap.value != null) {
      eventComment = "";

      for (String eleman in snap.value.keys) {
        keys.add(eleman);
      }
      keys.sort((String a, String b) => a.compareTo(b));
      for (String eleman in keys) {
        eventComment += snap.value[eleman];
        eventComment += "\n";
      }

      return eventComment;
    } else {
      eventComment = "Henüz Yorum Yapan Olmadı";
      return eventComment;
    }
  }

  static Future<bool> findUser(String userName) async {
    DataSnapshot snap;
    snap = await ref.child("Users").child(userName).once();
    if (snap.value == null) {
      return true;
    } else
      return false;
  }

  static Future<bool> getFriend(String displayName, String friendName) async {
    DataSnapshot snap;
    snap = await ref.child("Social").child(displayName).child("friend").once();
    if (snap.value != null) {
      if (snap.value.keys.contains(friendName)) {
        return false;
      }
      return true;
    }
  }

  static Future<List<String>> returnFriends(String userName) async {
    List<String> friendList = [];
    DataSnapshot snap;
    friendList.clear();
    try {
      snap = await ref.child("Social").child(userName).child("friend").once();
      for (String eleman in snap.value.keys) {
        friendList.add(eleman);
      }
      return friendList;
    } catch (e) {
      print(e.toString());
      return friendList;
    }
  }

  static Future<List<String>> returnRequests(String userName) async {
    List<String> requestList = [];
    DataSnapshot snap;
    requestList.clear();
    try {
      snap = await ref.child("Social").child(userName).child("request").once();
      for (String eleman in snap.value.keys) {
        requestList.add(eleman);
      }
      return requestList.toSet().toList();
    } catch (e) {
      print("buradan " + e.toString() + " buraya");
      return requestList;
    }
  }

  static Future<String> getEventDiscription(String eventId) async {
    DataSnapshot snap;
    snap = await ref.child("Events").child(eventId).child("instruction").once();
    return snap.value;
  }

  static void setUser(String uid, String email, String displayName) {
    ref
        .child("Users")
        .child(displayName)
        .set({"email": email, "displayName": displayName, "uid": uid});
    ref.child("UserNames").child(uid).set(displayName);
  }

  static Future<int> eventLength(String userName) async {
    DataSnapshot snap;
    snap = await ref.child("MyEvents").child(userName).once();

    if (snap.value != null) {
      return snap.value.length;
    } else {
      return 0;
    }
  }

  static Future<Map> getAllEventsStatus(
      String userName, List<String> eventIDs) async {
    Map stats = {};
    for (var event in eventIDs) {
      stats[event] = await getEventStatus(event);
    }
    return stats;
  }

  static Future<bool> getEventStatus(String eventID) async {
    DataSnapshot snap;
    snap = await ref.child("Events").child(eventID).once();
    return snap.value["isOpen"];
  }

  static Future<List<String>> getEventNames(String userName) async {
    DataSnapshot snap;
    eventList.clear();
    snap = await ref.child("MyEvents").child(userName).once();
    if (snap.value != null) {
      for (String eleman in snap.value.keys) {
        eventList.add(eleman);
      }
      return eventList;
    } else {
      return eventList;
    }
  }

  static Future<Map> getChoices(String eventId) async {
    DataSnapshot snap;
    Map dates = {};
    dates.clear();
    snap = await ref.child("Events").child(eventId).child("secenekler").once();

    dates = snap.value;

    return dates;
  }

  static Future<Map> getParticipantMap(String eventId) async {
    DataSnapshot snap;
    snap = await ref.child("ParticipantOfEvent").child(eventId).once();
    return snap.value;
  }

  static Future<List<String>> getParticipantChoices(String userName) async {
    List<String> choices = [];
    choices.clear();
    DataSnapshot snap;
    snap = await ref.child("ParticipantOfEvent").child(userName).once();
    if (snap.value != null) {
      for (String eleman in snap.value.keys) {
        choices.add(eleman);
      }
      return choices;
    } else
      return choices;
  }

  static Future<List<String>> getEmails() async {
    DataSnapshot snap;
    List<String> emails = [];
    snap = await ref.child("Users").once();
    for (var t in snap.value.keys) {
      emails.add(snap.value[t]["email"]);
    }
    return emails;
  }

  static Future<void> setChoices(
      Map choices, String eventId, String userName) async {
    ref.child("ParticipantOfEvent").child(eventId).child(userName).set(choices);
  }

  static void leaveEvent(String eventID, String userName) {
    ref.child("MyEvents").child(userName).child(eventID).remove();
    ref.child("ParticipantOfEvent").child(eventID).child(userName).remove();
  }

  static void removeEvent(String eventID) async {
    var allChoices = await getParticipantMap(eventID);
    for (var participant in allChoices.keys) {
      leaveEvent(eventID, participant);
    }
    ref.child("ParticipantOfEvent").child(eventID).remove();
    ref.child("Events").child(eventID).remove();
    ref.child("Comments").child(eventID).remove();
  }

  static Future<List<String>> getEventTitles(List<String> events) async {
    DataSnapshot snap;
    eventTitle.clear();
    try {
      for (String eleman in events) {
        snap = await ref.child("Events").child(eleman).child("title").once();
        eventTitle.add(snap.value);
      }
      return eventTitle.toSet().toList();
    } catch (e) {
      print(e.toString());
      return eventTitle;
    }
  }

  static Future<DataSnapshot> getUser(String userName) async {
    DataSnapshot snap;
    snap = await ref.child("Users").child(userName).once();
    return snap;
  }

  static Future<String> getUserDisplayName(String uid) async {
    DataSnapshot snap;
    snap = await ref.child("UserNames").child(uid).once();
    return snap.value;
  }

  static setUserDisplayName(String uid, String displayName) {
    ref.child("UserNames").child(uid).set(displayName);
  }

  static Future<DataSnapshot> getUserName(String uid) async {
    DataSnapshot snap;
    snap = await ref.child("UserNames").child(uid).once();
    return snap;
  }

  static closeEvent(String eventID) {
    ref.child("Events").child(eventID).child("isOpen").set(false);
  }

  static void setParticipantOfEvent(
      String eventId, List<String> users, Map secenekler) {
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    Map sample = new Map();
    for (String user in users) {
      sample[user] = currentTime;
      for (String elemmans in secenekler.keys) {
        ref
            .child("ParticipantOfEvent")
            .child(eventId)
            .child(user)
            .child(elemmans)
            .set(false);
      }
    }
  }

  static Future<String> getCreator(String eventID) async {
    DataSnapshot snap;
    snap = await ref.child("Events").child(eventID).once();
    return snap.value["creatorId"];
  }

  static Future<void> setEventInstruction(String instruction, String eventID) {
    ref.child("Events").child(eventID).child("instruction").set(instruction);
  }

  static void createEvent(String creatorName, Map gecici, List<String> users,
      String title, String instruction) async {
    users.add(creatorName);
    Map seceneklerx = new Map();
    for (var key in gecici.keys) {
      seceneklerx[key.toString()] = {
        "tarih": gecici[key]["tarih"],
        "baslangic": gecici[key]["baslangic"],
        "bitis": gecici[key]["bitis"]
      };
    }
    var key = Generate.getRandom(15);
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    ref.child("Events").child(key).set({
      "isOpen": true,
      "instruction": instruction,
      "title": title,
      "secenekler": seceneklerx,
      "location": {
        "g": 0,
        "lat": 1,
        "long": 2,
      },
      "creatorId": creatorName,
      "timeStamp": currentTime
    });

    for (String eleman in users) {
      DataSnapshot user = await getUser(eleman);

      setMyEvents(user.value["displayName"], key);
    }
    setMyEvents(creatorName, key);

    setParticipantOfEvent(key, users, seceneklerx);
  }

  static void setMyEvents(String displayName, String eventId) {
    ref.child("MyEvents").child(displayName).child(eventId).set(true);
  }

  static void requestFriend(String user, String getReq) {
    ref.child("Social").child(getReq).child("request").child(user).set(true);
  }

  static void addFriend(String user, String getReq) {
    ref.child("Social").child(user).child("friend").child(getReq).set(true);
    ref.child("Social").child(getReq).child("friend").child(user).set(true);
    ref.child("Social").child(user).child("request").child(getReq).remove();
  }

  static void dontAddFriend(String user, getReq) {
    ref.child("Social").child(user).child("request").child(getReq).remove();
  }
}
