import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/screens/apbar/arkadasArama.dart';
import 'package:flutter_first_app/screens/apbar/arkadasIstekleri.dart';
import 'package:flutter_first_app/screens/apbar/arkadaslarim.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'package:provider/provider.dart';
import './apbar.dart';
import 'package:flutter_first_app/main.dart';
class ArkadasEkle extends StatefulWidget {
  Key key = new Key("asd");

  @override
  Ekle createState() => Ekle();
}

class Ekle extends State<ArkadasEkle> {
  int reqLength = 0;
  List<String> reqList = [];
  int friLength = 0;
  List<String> friList = [];
  String userName = "";
  Future<void> setBilgiler(User user) async {
    userName = user.displayName;
    reqList = await user.returnReqList(user.displayName);
    if (reqList != null) {
      reqLength = reqList.length;
    }

    print(reqList);
  }

  PageController kontrol =
      new PageController(initialPage: 1, viewportFraction: .99);
  String aranacakKisi = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(reqList);
    bool a = true;
    return Scaffold(
      appBar: Apbar(context: context, widget: widget).bar(),
      body: NotificationListener<OverscrollNotification>(
        onNotification: (notific) {
          print(notific.overscroll);
          if (notific.overscroll < 0 && a) {
            a = !a;
            //sayfa yenileme
            user.initialize(user.uid);
            setState(() {});
          }

          return true;
        },
        child: FutureBuilder(
          future: setBilgiler(user),
          builder: (context, snapShot) {
            print(snapShot.connectionState);
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.amber,
              ));
            } else {
              return PageView(
                
                controller: kontrol,
                children: [
                  //Arkadaş arama
                  ArkadasArama(
                    kontrol: kontrol,
                    userName: userName,
                  ),
                  //Arkadaş istkleri
                  ArkadasIstekleri(
                    kontrol: kontrol,
                    reqLength: reqLength,
                    reqList: reqList,
                    userName: userName,
                  ),
                  //Arkadaşlarım
                  Arkadaslarim(kontrol: kontrol),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
