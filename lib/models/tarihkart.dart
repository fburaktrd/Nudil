import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/events.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/planlama.dart';
import 'package:flutter_first_app/screens/wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'oyOncesi.dart';
import 'user.dart';
import 'package:flutter_first_app/screens/apbar/apbar.dart';

class TarihKart extends StatefulWidget {
  @override
  _TarihKartState createState() => _TarihKartState();
}

class _TarihKartState extends State<TarihKart> {
  List<String> titles = [];
  List<Widget> olustur = [];
  List<String> eventNames = [];
  int sayi = 0;
  String userName = "";
  Map stats;
  Future<void> setBilgiler(User user) async {
    eventNames =
        await DataBaseConnection.getEventNames(user.displayName.toString());
    //Tüm eventlerin kapalı veya açık olduğu durum.
    stats = await DataBaseConnection.getAllEventsStatus(
        user.displayName, eventNames);
    sayi = await DataBaseConnection.eventLength(user.displayName.toString());
    titles = await DataBaseConnection.getEventTitles(eventNames);
    print(this.mounted);

    olustur = listeYapici(sayi, titles, eventNames, context, stats);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    userName = user.displayName;
    return Scaffold(
      appBar: Apbar(context: context, widget: widget).x(),
      body: NotificationListener<OverscrollNotification>(
        onNotification: (page) {
          if (page.overscroll < -5) {
            setState(() {});
          }
          return true;
        },
        child: FutureBuilder(
          future: setBilgiler(user),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.amber,
              ));
            } else {
              return Container(
                decoration: BoxDecoration(),
                child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  children: olustur,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: RawMaterialButton(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff30374b),
            borderRadius: BorderRadius.circular(7.30),
          ),
          padding: EdgeInsets.all(8),
          child: Text('Planlama',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Planlama())),
      ),
    );
  }

  List<Widget> listeYapici(int sayi, List<String> title, List<String> eventID,
      BuildContext context, Map stats) {
    List<Widget> liste = [];
    for (int i = 0; i < title.length; i++) {
      Events event = new Events(
          userName: userName,
          eventID: eventID.elementAt(i),
          eventName: title.elementAt(i),
          status: stats[eventID.elementAt(i)]);
      print(i);
      if (!(event.status)) {
        Widget a = GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return OyOncesi(event: event);
              },
            ));
          },
          onDoubleTap: () async {
            print(userName + " " + event.creator);
            if (userName == event.creator) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 3,
                          horizontal: 40),
                      title: Text("Uyarı"),
                      content: Text(
                          "${event.eventName} isimli etkinlik ile ilgili yapabileceğiniz işlemler"),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          horizontal: 40),
                                      title: Text("Uyarı"),
                                      content: Text(
                                          "${event.eventName} isimli eventi herkesten sileceksiniz. Emin misiniz ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              DataBaseConnection.removeEvent(
                                                  event.eventID);

                                              final snackBar = SnackBar(
                                                backgroundColor:
                                                    Colors.lightBlue,
                                                content: Text(
                                                    "${event.eventName} isimli eventi herkesten sildiniz.",
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);

                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Evet")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Hayır")),
                                      ],
                                    );
                                  });
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventi sil")),
                      ],
                    );
                  });
            } else {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 3,
                          horizontal: 40),
                      title: Text("Menü"),
                      content: Text(
                          "${event.eventName} isimli etkinlik ile ilgili yapabileceğiniz işlemler"),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          horizontal: 40),
                                      title: Text("Uyarı"),
                                      content: Text(
                                          "${event.eventName} isimli etkinlikten ayrılmak istediğinize emin misiniz ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              DataBaseConnection.leaveEvent(
                                                  event.eventID,
                                                  event.userName);
                                              final snackBar = SnackBar(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  content: Text(
                                                      "${event.eventName} isimli eventten başarıyla ayrıldınız.",
                                                      style: TextStyle(
                                                          fontSize: 20)));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Evet")),
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Hayır"))
                                      ],
                                    );
                                  });
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventten ayrıl.")),
                      ],
                    );
                  });
            }
          },
          child: Card(
            color: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
            margin: EdgeInsets.all(4),
            clipBehavior: Clip.antiAlias,
            child: Scaffold(
              floatingActionButton:
                  FloatingActionButton(child: Icon(Icons.check)),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff30374b),
                ),
                child: Text(
                  title[i],
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ),
        );
        liste.add(a);
      } else {
        Widget a = GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return OyOncesi(event: event);
              },
            ));
          },
          onDoubleTap: () async {
            print(userName + " " + event.creator);
            if (userName == event.creator) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 3,
                          horizontal: 40),
                      title: Text("Uyarı"),
                      content: Text(
                          "${event.eventName} isimli etkinlik ile ilgili yapabileceğiniz işlemler"),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          horizontal: 40),
                                      title: Text("Uyarı"),
                                      content: Text(
                                          "${event.eventName} isimli eventi herkesten sileceksiniz. Emin misiniz ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              DataBaseConnection.removeEvent(
                                                  event.eventID);

                                              final snackBar = SnackBar(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  content: Text(
                                                      "${event.eventName} isimli eventi herkesten sildiniz.",
                                                      style: TextStyle(
                                                          fontSize: 20)));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Evet")),
                                        TextButton(
                                            onPressed: () {
                                              print(event.aciklama);
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Hayır")),
                                      ],
                                    );
                                  });
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventi sil")),
                        TextButton(
                            onPressed: () async {
                              List<String> choicesAsList = [];
                              Map mostDecided = {};
                              List<String> lastDecision = [];
                              int max = 0;
                              for (var key in event.tarihler.keys) {
                                for (var participant in event.katilan.keys) {
                                  if (event.katilan[participant][key] == true) {
                                    choicesAsList.add(key);
                                  }
                                }
                              }
                              print(choicesAsList);
                              for (var key in event.tarihler.keys) {
                                if (mostDecided.keys.contains(key)) {
                                  continue;
                                }
                                var foundElements =
                                    choicesAsList.where((e) => e == key);
                                mostDecided[key] = foundElements.length;
                                if (foundElements.length > max) {
                                  max = foundElements.length;
                                }
                              }
                              for (var choiceIndex in mostDecided.keys) {
                                if (mostDecided[choiceIndex] == max) {
                                  lastDecision.add(choiceIndex);
                                }
                              }
                              print(lastDecision);
                              List<String> radioSecenekler = [];
                              if (lastDecision.length > 1) {
                                bool _checked = false;
                                for (var dec in lastDecision) {
                                  String secenek =
                                      "Tarih: ${event.tarihler[dec]["tarih"]}  Başlangıç: ${event.tarihler[dec]["baslangic"]}  Bitiş: ${event.tarihler[dec]["bitis"]}";
                                  radioSecenekler.add(secenek);
                                }
                                
                              } else {
                                var secilen =
                                    event.tarihler[lastDecision.elementAt(0)];
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.lightBlue,
                                    content: Text(
                                        "${event.eventName} isimli etkinlik için ${secilen["tarih"]} tarihinde saat ${secilen["baslangic"]}-${secilen["bitis"]} saatlerine karar verildi !\nİyi eğlenceler !",
                                        style: TextStyle(fontSize: 15)));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                event.setEventInstructionAfterDecide(secilen);
                                print(event.aciklama);
                                DataBaseConnection.closeEvent(event.eventID);
                              }

                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventi sonlandır")),
                      ],
                    );
                  });
            } else {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 3,
                          horizontal: 40),
                      title: Text("Uyarı"),
                      content: Text(
                          "${event.eventName} isimli etkinlik ile ilgili yapabileceğiniz işlemler"),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        horizontal: 40,
                                      ),
                                      title: Text("Uyarı"),
                                      content: Text(
                                          "${event.eventName} isimli etkinlikten çıkmak isteidğinize emin misiniz ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              DataBaseConnection.leaveEvent(
                                                  event.eventID,
                                                  event.userName);
                                              final snackBar = SnackBar(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  content: Text(
                                                      "${event.eventName} isimli eventten başarıyla ayrıldınız.",
                                                      style: TextStyle(
                                                          fontSize: 20)));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Evet")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text("Hayır")),
                                      ],
                                    );
                                  });
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventten ayrıl.")),
                      ],
                    );
                  });
            }
          },
          child: Card(
            color: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
            margin: EdgeInsets.all(4),
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff30374b),
              ),
              child: Text(
                title[i],
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        );
        liste.add(a);
      }
    }

    return liste;
  }
}
