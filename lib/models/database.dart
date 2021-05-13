import 'package:firebase_database/firebase_database.dart';


class DataBaseConnection {
  static final ref = FirebaseDatabase.instance.reference();
  static void setUser(String uid, String email, String displayName) {
    ref.child("Users").child(uid).set({
      "email": email,
      "displayName": displayName,
      "uid": uid
    });
  }
}