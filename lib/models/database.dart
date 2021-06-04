import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'package:flutter_first_app/models/generate.dart';

class DataBaseConnection {



  static final ref = FirebaseDatabase.instance.reference();
  static List<String> eventList = [];
  static List<String> eventTitle = [];
  static Future<String> getEventDiscription(String eventId)async{
    DataSnapshot b;
    b = await ref.child("Events").child(eventId).child("instruction").once();
    return b.value;
  }
  static void setUser(String uid, String email, String displayName) {
    ref
        .child("Users")
        .child(displayName)
        .set({"email": email, "displayName": displayName, "uid": uid});
  }
  static Future<int> eventLength(String userName) async {
    DataSnapshot b;
    b = await ref.child("MyEvents").child(userName).once();
    print("burası");
    print(b.value.length);
    return b.value.length;
  }
  static Future<List<String>> getEventNames(String userName)async{
    DataSnapshot b;
    b = await ref.child("MyEvents").child(userName).once();
    for(String eleman in b.value.keys){
      eventList.add(eleman);
    }
    return eventList;
  }
  static Future<List<String>> getEventTitles(List<String> events)async{
    DataSnapshot b;
    for(String eleman in events){
      b= await ref.child("Events").child(eleman).child("title").once();
      eventTitle.add(b.value);
    }
    return eventTitle;

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
  static void createEvent(String creatorName, Map gecici,List<String> users)async {
    Map seceneklerx = new Map();
    for(var key in gecici.keys){
      seceneklerx[key.toString()]={
        "tarih":gecici[key]["tarih"],
        "baslangic":gecici[key]["baslangic"],
        "bitis":gecici[key]["bitis"]
      };
    }
    var key=Generate.getRandom(15);
    var currentTime = DateTime.now().microsecondsSinceEpoch;
    ref.child("Events").child(key).set({
      "secenekler":seceneklerx,
      "location": {
        "g": 0,
        "lat": 1,
        "long": 2,
      },
      "creatorId": creatorName,
      "timeStamp": currentTime
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
