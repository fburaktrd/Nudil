import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_first_app/models/generate.dart';
import 'package:intl/intl.dart';

class DataBaseConnection {
  static final ref = FirebaseDatabase.instance.reference();
  static List<String> eventList = [];
  static List<String> eventTitle = [];
  static List<String> friendList = [];
  static List<String> requestList = [];
  static String eventComment = "";

  static void setComments(String displayName, String eventId, String comment) {
    var now = new DateTime.now();
    String formattedTime = DateFormat('kk:mm').format(now);
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    ref
        .child("Comments")
        .child(eventId)
        .child(currentTime.toString())
        .set(formattedTime + displayName + ":" + comment);
  }

  static Future<String> getComments(String eventId) async {
    List<String> keys = [];
    DataSnapshot b;
    b = await ref.child("Comments").child(eventId).once();
    if (b.value != null) {
      eventComment = "";
      print(b.value);

      for (String eleman in b.value.keys) {
        keys.add(eleman);
      }
      keys.sort((String a, String b) => a.compareTo(b));
      for (String eleman in keys) {
        eventComment += b.value[eleman];
        eventComment += "\n";
      }

      return eventComment;
    } else {
      eventComment = "Henüz Yorum Yapan Olmadı";
      return eventComment;
    }
  }

  static Future<List<String>> returnFriends(String userName) async {
    DataSnapshot b;
    friendList.clear();
    try {
      b = await ref.child("Social").child(userName).child("friend").once();
      for (String eleman in b.value.keys) {
        friendList.add(eleman);
      }
      return friendList;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<String>> returnRequests(String userName) async {
    DataSnapshot b;
    requestList.clear();
    try {
      b = await ref.child("Social").child(userName).child("request").once();
      for (String eleman in b.value.keys) {
        requestList.add(eleman);
      }
      return requestList;
    } catch (e) {
      print(e.toString());
      return requestList;
    }
  }

  static Future<String> getEventDiscription(String eventId) async {
    DataSnapshot b;
    b = await ref.child("Events").child(eventId).child("instruction").once();
    return b.value;
  }

  static void setUser(String uid, String email, String displayName) {
    ref
        .child("Users")
        .child(displayName)
        .set({"email": email, "displayName": displayName, "uid": uid});
    ref.child("UserNames").child(uid).set(displayName);
  }

  static Future<int> eventLength(String userName) async {
    DataSnapshot b;
    b = await ref.child("MyEvents").child(userName).once();

    if (b.value != null) {
      return b.value.length;
    } else {
      return 0;
    }
  }

  static Future<List<String>> getEventNames(String userName) async {
    DataSnapshot b;
    eventList.clear();
    b = await ref.child("MyEvents").child(userName).once();
    if (b.value != null) {
      for (String eleman in b.value.keys) {
        eventList.add(eleman);
      }
      return eventList;
    } else {
      return eventList;
      
    }
  }

  static Future<List<String>> getEventTitles(List<String> events) async {
    DataSnapshot b;
    eventTitle.clear();
    try {
      for (String eleman in events) {
        b = await ref.child("Events").child(eleman).child("title").once();
        eventTitle.add(b.value);
      }
      return eventTitle;
    } catch (e) {
      print(e.toString());
      return eventTitle;
    }
  }

  static Future<DataSnapshot> getUser(String userName) async {
    DataSnapshot b;
    b = await ref.child("Users").child(userName).once();
    return b;
  }

  static Future<String> getUserDisplayName(String uid) async {
    DataSnapshot b;
    b = await ref.child("UserNames").child(uid).once();
    return b.value;
  }

  static setUserDisplayName(String uid, String displayName) {
    ref.child("UserNames").child(uid).set(displayName);
  }

  static Future<DataSnapshot> getUserName(String uid) async {
    DataSnapshot b;
    b = await ref.child("UserNames").child(uid).once();
    return b;
  }

  static void setParticipantOfEvent(String eventId, List<String> users) {
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    Map sample = new Map();
    for (String user in users) {
      sample[user] = currentTime;
    }
    ref.child("ParticipantOfEvent").child(eventId).set(sample);
  }

  static void createEvent(String creatorName, Map gecici, List<String> users,
      String title, String instruction) async {
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

    /* for(String eleman in users){
      DataSnapshot user =await getUser(eleman);
      print(user.value);
      setMyEvents(user.value["displayName"], key);
    } */
    setMyEvents(creatorName, key);
    setParticipantOfEvent(key, users);
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
