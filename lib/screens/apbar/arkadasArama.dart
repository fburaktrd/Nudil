import 'package:flutter/material.dart';

import '../../models/database.dart';

class ArkadasArama extends StatelessWidget{
  final PageController kontrol;
  final String userName;
  ArkadasArama({this.kontrol,this.userName});
  
  @override
  Widget build(BuildContext context) {
    String aranacakKisi = "";
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RawMaterialButton(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Arkadaş İstekleri"),
                  Icon(Icons.chevron_right_sharp)
                ],
              ),
            ),
            onPressed: (){
              kontrol.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
            }
          ),
          Container(
            padding: EdgeInsets.all(9),
            margin: EdgeInsets.all(7),
            decoration: ShapeDecoration(color:Color(0xff30374b).withAlpha(240),
                shape:BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
            ),

            child: Text("Arkadaş Ekle",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

          ),
          Container(
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withAlpha(200)),
            child: Container(
              constraints: BoxConstraints(maxWidth: 200),
              margin: EdgeInsets.all(12),
              child: TextField(
                
                decoration: InputDecoration(
                  
                  hintText: "ara",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 16,
                ),
                toolbarOptions:
                    ToolbarOptions(selectAll: true, copy: true, paste: true),
                autocorrect: false,
                keyboardType: TextInputType.text,
                onSubmitted: (arama) async{

                  //aranacak kişi buradan
                  aranacakKisi = arama;
                  bool userBool =await DataBaseConnection.findUser(aranacakKisi);


                  if(userBool){

                    await showDialog(context: context, builder: (context){

                      return AlertDialog(
                        insetPadding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/3,horizontal: 40),
                        title: Text("Uyarı"),
                        content: Text("@$arama isimli kişi bulunamadı."),
                        actions: [
                          TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text("Tamam")),
                        ],

                      );
                    });

                  }
                  else {
                    bool b = await  DataBaseConnection.getFriend(userName, aranacakKisi);
                    if (b) {
                      bool x;
                      x = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context)
                                          .size
                                          .height /
                                      3,
                                  horizontal: 40),
                              title: Text("Yabancı ?"),
                              content: Text(
                                  "@$arama arkadaşınız değil.\nEklemek istediğinize emin misiniz?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("İptal")),
                                TextButton(
                                    onPressed: () {
                                      DataBaseConnection.requestFriend(
                                          userName, arama);
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("Ekle"))
                              ],
                            );
                          });
                    } else {
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
                              content: Text("@$arama zaten arkadaşınız."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("Tamam")),
                              ],
                            );
                          });
                    }
                  }

                  
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(14),
            padding: EdgeInsets.all(15),
            child: Text(aranacakKisi.length == 0 ? "" : "@" + aranacakKisi),
          ),
          
        ],
      ),
    );
    
  }
}