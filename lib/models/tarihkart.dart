import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/models/events.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/planlama.dart';
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
  Future<void> setBilgiler(User user) async {
    eventNames =
        await DataBaseConnection.getEventNames(user.displayName.toString());
    sayi = await DataBaseConnection.eventLength(user.displayName.toString());
    titles = await DataBaseConnection.getEventTitles(eventNames);
    print(this.mounted);

    olustur = listeYapici(sayi, titles, eventNames, context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
      BuildContext context) {
    List<Widget> liste = [];
    for (int i = 0; i < title.length; i++) {
      Events event = new Events(
          userName: userName,
          eventID: eventID.elementAt(i),
          eventName: title.elementAt(i));
      print(event.status);
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
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventi sil")),
                        TextButton(
                            onPressed: () {
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
                            onPressed: () {
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
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Eventi sil")),
                        TextButton(
                            onPressed: () {
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
                            onPressed: () {
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
