import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'package:flutter_first_app/models/generate.dart';

class DataBaseConnection {

  static final ref = FirebaseDatabase.instance.reference();

  static void setUser(String uid, String email, String displayName) {
    ref
        .child("Users")
        .child(displayName)
        .set({"email": email, "displayName": displayName, "uid": uid});
  }

  static void createUserName(String userName) async {
    ref.child("UserNames").child(userName).set(userName);
  }
  static Future<DataSnapshot> getUser(String userName) async {
    DataSnapshot b;
    b = await ref.child("Users").child(userName).once();
    return b;
  }

  static Future<DataSnapshot> getUserName(String userName) async {
    DataSnapshot b;
    b = await ref.child("UserNames").child(userName).once();
    return b;
  }
  static void setParticipantOfEvent(String eventId,List<String> users){
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    Map sample = new Map();
    for(String user in users){
      sample[user] = currentTime;
      
    }
    ref.child("ParticipantOfEvent").child(eventId).set(sample);
  }
  static void createEvent(String creatorName, Map b,List<String> users)async {
    var key=Generate.getRandom(15);

    var currentTime = DateTime.now().microsecondsSinceEpoch;
    ref.child("Events").child(key).set({
      "location": {
        "g": 0,
        "lat": 1,
        "unuttum": 2,
      },
      "creatorId": creatorName,
      "timeStamp": currentTime,
      "secenekler": b["secenekler"]
    });

    for(String eleman in users){
      DataSnapshot user =await getUser(eleman);
      print(user.value);
      setMyEvents(user.value["displayName"], key);
    }
    setMyEvents(creatorName, key);
    setParticipantOfEvent(key, users);
  }
  static void setMyEvents(String displayName,String eventId){
    ref.child("MyEvents").child(displayName).child(eventId).set(true);
  }
}
