import 'package:flutter_first_app/models/database.dart';

class User {
  final String uid;
  String displayName;
  List<String> friends;
  List<String> requests;

  User({this.uid}) {
    initialize(uid);
    
  }

  initialize(String uid) async {
    await getDisplayNameFromFirebase(uid);
    await getFriends(displayName);
    await getRequestList(displayName);
  }

  getDisplayNameFromFirebase(String uid) async {
    displayName = await DataBaseConnection.getUserDisplayName(uid);
  }

  getFriends(String displayName) async {
    friends = await DataBaseConnection.returnFriends(displayName);
    // print(friends);
  }

  getRequestList(String displayName) async {
    requests = await DataBaseConnection.returnRequests(displayName);
  }

  Future<List<String>> returnReqList(String displayName) async {
    requests = await DataBaseConnection.returnRequests(displayName);
    return requests;
  }
}
