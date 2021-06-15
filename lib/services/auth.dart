import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getUseruid() async {
    FirebaseUser cur_user = await _auth.currentUser();
    return cur_user.uid;
  }
  Future getUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      print("get user iç");
      print(user.uid);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // create user obj based on FirabaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  void sendResetReqPassword(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }
  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return [user, _userFromFirebaseUser(user)];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future realRegister(String email, String password, String displayName) async {
    var val = await registerWithEmailAndPassword(email, password);
    DataBaseConnection.setUser(val[0].uid, email, displayName);
    print("buraaassıı hoştur");
    print(val[0].displayName);
    DataBaseConnection.setUserDisplayName(val[0].uid, displayName);
    return val[1];
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
