import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/services/auth.dart';

import 'arkadasEkle.dart';

final AuthService _auth = AuthService();

class Apbar {
  final BuildContext context;
  final Widget widget;
  Apbar({this.context, this.widget});

  AppBar x() {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Text("Nudıl"),
        backgroundColor: Color(0xff30374b),
        actions: [
          IconButton(
              icon: Icon(Icons.person_add_alt_1),
              onPressed: () {
                widget.key.toString() == "[<'asd'>]"
                    ? Navigator.pop(context)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RestartWidget(child: ArkadasEkle())));
              }),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                String uid = await _auth.getUseruid();
                String userName =
                    await DataBaseConnection.getUserDisplayName(uid);
                await _auth.signOut();
                final snackBar = SnackBar(
                    backgroundColor: Colors.lightBlue,
                    content: Text(
                      "Başarıyla çıkış yapıldı , görüşmek üzere $userName !",
                      style: TextStyle(fontSize: 20),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
        ]);
  }
}
