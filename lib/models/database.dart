import 'package:firebase_database/firebase_database.dart';

class DataBaseConnection {
  static final ref = FirebaseDatabase.instance.reference();

  static void setUser(String uid, String email, String displayName) {
    ref
        .child("Users")
        .child(uid)
        .set({"email": email, "displayName": displayName, "uid": uid});
  }

  static void createUserName(String userName) async {
    ref.child("UserNames").child(userName).set(userName);
  }

  static Future<DataSnapshot> getUserName(String userName) async {
    DataSnapshot b;
    b = await ref.child("UserNames").child(userName).once();
    return b;
  }
}
