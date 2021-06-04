import 'dart:math';

import 'package:flutter/material.dart';

import './listeButonu.dart';

class ArkadasListe extends StatefulWidget {
  //Kişinin arkadaş listesi
  List<Widget> friends = List.generate(100, (index) {
    Widget x = ListeButon(index: index);

    return x;
  });

  ArkListe createState() => ArkListe();
}

class ArkListe extends State<ArkadasListe> {
  List<Widget> asilListe = [];
  String search = '';
  List<Widget> aramaListe=[];
  @override
  void initState() {
    super.initState();
    asilListe = widget.friends;
  }
  Map seciliArk = new Map();
  
  @override
  Widget build(BuildContext context) {
    List<Widget> seciliWidget = [];
     //user type
    int kisi=0;
    for (int i = 0; i < asilListe.length; i++) {
      
      if (asilListe.cast<ListeButon>().elementAt(i).seci == true) {
        seciliWidget.add(
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blueGrey[800],
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(4),
            width: 50,
            height: 50,
            child: Text(
              "${asilListe.cast<ListeButon>().elementAt(i).index}",
              style: TextStyle(color: Colors.white),
            ),
          )
        );
        seciliArk[kisi++]=asilListe.cast<ListeButon>().elementAt(i).index;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(100),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width/1.22,
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        
                        onChanged: (ad){
                          search=ad;
                          //Arama yapıldığında gösterilecek liste
                          aramaListe=asilListe.cast<ListeButon>().where((element) => element.index.toString().contains(search)).toList();
                          setState(() {
                            
                          });
                        },
                        onSubmitted: (aranan)async{
                          //Arkadaş olmayan kişi eklensin mi?
                          bool x;
                          if(aramaListe.isEmpty){
                            x=await showDialog(context: context, builder: (context){
                              return AlertDialog(
                                insetPadding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/3,horizontal: 40),
                                title: Text("Yabancı ?"),
                                content: Text("@$aranan arkadaşınız değil.\nEklemek istediğinize emin misiniz?"),
                                actions: [
                                  TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text("İptal")),
                                  TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: Text("Ekle"))
                                ],

                              );
                            });
                          }
                          print(x);

                        },
                      ),
                    ),
                    GestureDetector(
                      onVerticalDragCancel: (){setState(() {
                        
                      });},
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.22,
                        height: MediaQuery.of(context).size.height/1.44,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: search.length==0?asilListe:aramaListe,
                          
                          childAspectRatio: .8,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  
                  width: MediaQuery.of(context).size.width/1.33,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Row(
                        
                        children: seciliWidget.length==0?[Container(color: Colors.amber,child: Text("Ekleme \nyapılmadı"),alignment: Alignment.center,padding: EdgeInsets.all(8),),]:seciliWidget,
                      ),
                    ),
                  ),
                ),
                //Eklenen kişiler Planlamya bu butondan dönecek
                RawMaterialButton(
                  onPressed: (){
                    print(seciliArk.values);
                    Navigator.of(context).pop(seciliArk);
                    setState(() {
                      
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0,8,0,8),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    
                    height: 50,
                    width: MediaQuery.of(context).size.width/1.33,
                    alignment: Alignment.center,
                    child: Text("Bitti"),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
