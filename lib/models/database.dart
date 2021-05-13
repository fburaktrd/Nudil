import 'package:firebase_database/firebase_database.dart';


class DataBaseConnection {
  final ref = FirebaseDatabase.instance.reference();
  void setUser(String uid, String email, String displayName) {
    ref.child("Users").child(uid).set({
      "email": email,
      "displayName": displayName,
      "uid": uid
    });
  }
}