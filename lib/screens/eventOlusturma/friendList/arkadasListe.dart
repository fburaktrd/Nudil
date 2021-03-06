

import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/services/auth.dart';

import './listeButonu.dart';

class ArkadasListe extends StatefulWidget {
  
  

  ArkListe createState() => ArkListe();
}

class ArkListe extends State<ArkadasListe> {
  String userName="";
  final AuthService _auth = AuthService();
  Future<void> setBilgiler()async{
    String uid =await _auth.getUseruid();
    print(uid);
    userName=await DataBaseConnection.getUserDisplayName(uid);
    getFriends(userName);
    setState(() {

    });
  }
  List<String> friendList = [];
  List<Widget> asilListe = [];
  String search = '';
  List<Widget> aramaListe=[];

  List<Widget> friends(List<String> lisx){
    List<Widget> bruh=[];
    for(int i=0;i<lisx.length;i++){
      Widget x = ListeButon(isim: lisx.elementAt(i));
      bruh.add(x);
    }

    return bruh;
  }

  Future<void> getFriends(String userName1)async{
    friendList=await DataBaseConnection.returnFriends(userName1);
    print(friendList);
    asilListe=friends(friendList);
    setState(() {
      
    });


  }

  @override
  void initState() {
    super.initState();
    setBilgiler();
    

  }
  Set<String> seciliArk = {};
  
  @override
  Widget build(BuildContext context) {
    
    List<Widget> seciliWidget = [];
     //user type
    
    for (int i = 0; i < asilListe.length; i++) {
      
      if (asilListe.cast<ListeButon>().elementAt(i).seci == true) {
        print(asilListe.cast<ListeButon>().elementAt(i).isim);
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
              "${asilListe.cast<ListeButon>().elementAt(i).isim}",
              style: TextStyle(color: Colors.white),
            ),
          )
        );
        seciliArk.add(asilListe.cast<ListeButon>().elementAt(i).isim);
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
                        decoration: InputDecoration(border: InputBorder.none,hintText: "Aramak istedi??iniz ki??i"),
                        
                        onChanged: (ad){
                          search=ad;
                          //Arama yap??ld??????nda g??sterilecek liste
                          aramaListe=asilListe.cast<ListeButon>().where((element) => element.isim.contains(search)).toList();
                          setState(() {
                            
                          });
                        },
                        onSubmitted: (aranan)async{
                          //Arkada?? olmayan ki??i eklensin mi?
                          bool x;
                          if(aramaListe.isEmpty){
                            x=await showDialog(context: context, builder: (context){
                              return AlertDialog(
                                insetPadding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/3,horizontal: 40),
                                title: Text("Uyar??"),
                                content: Text("@$aranan ki??i arkada????n??z de??il.\ L??tfen arkada?? ekledikten sonra tekrar deneyin."),
                                actions: [
                                  TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text("Tamam")),
                                 
                                ],

                              );
                            });
                          }
                          print(x);

                        },
                      ),
                    ),
                    GestureDetector(
                      onVerticalDragCancel: (){
                        setState(() {
                          
                        });
                      },
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
                        
                        children: seciliWidget.length==0?[Container(color: Colors.amber,child: Text("Ekleme \nyap??lmad??"),alignment: Alignment.center,padding: EdgeInsets.all(8),),]:seciliWidget,
                      ),
                    ),
                  ),
                ),
                //Eklenen ki??iler Planlamya bu butondan d??necek
                RawMaterialButton(
                  onPressed: (){
                    
                    List<String> bro=seciliArk.toList();
                    Navigator.of(context).pop(bro);
                    
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
