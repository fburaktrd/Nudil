import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/services/auth.dart';
import './apbar.dart';
import 'package:flutter_first_app/main.dart';


class ArkadasEkle extends StatefulWidget {
  Key key=new Key("asd");
 
  @override
  Ekle createState() => Ekle();
}

class Ekle extends State<ArkadasEkle> {
  int reqLength=0;
  List<String> reqList = [];
  String userName="";
  final AuthService _auth = AuthService();
  Future<void> setBilgiler()async{
    String uid =await _auth.getUseruid();
    print(uid);
    userName=await DataBaseConnection.getUserDisplayName(uid);

    reqList=await DataBaseConnection.returnRequests(userName);
    reqLength=reqList.length;
    print(reqList);
    setState(() {
      
    });
  }



  PageController kontrol=new PageController(initialPage: 1,viewportFraction: .99);
  String aranacakKisi = "";
@override
  void initState(){
    
    super.initState();
    setBilgiler();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apbar(context: context,widget: widget).x(),
      
      body: NotificationListener<OverscrollNotification>(
        onNotification: (notific){

          print(notific.overscroll);
          if(notific.overscroll<0){
            
            //sayfa yenileme
            RestartWidget.restartApp(context);
          }
          
          return true;
        },
        child: PageView(
          controller: kontrol,
          children: [
            //Arkadaş arama
            Container(
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
                          bool x;
                            x=await showDialog(context: context, builder: (context){
                              return AlertDialog(
                                insetPadding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/3,horizontal: 40),
                                title: Text("Yabancı ?"),
                                content: Text("@$arama arkadaşınız değil.\nEklemek istediğinize emin misiniz?"),
                                actions: [
                                  TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text("İptal")),
                                  TextButton(onPressed: (){
                                    DataBaseConnection.requestFriend(userName, arama);
                                    Navigator.of(context).pop(true);}, child: Text("Ekle"))
                                ],

                              );
                            });
                          

                          setState(() {});
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
            ),
            //Arkadaş istkleri
            Container(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RawMaterialButton(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.chevron_left_sharp),
                            Text("Arkadaş ara")
                          ],
                        ),
                      ),
                      onPressed: (){
                        kontrol.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                      }
                    ),
                    
                    Column(
                      children: List.generate(reqLength, (index){
                        return Container(
                          padding: EdgeInsets.fromLTRB(8,24,16,20),
                          alignment: Alignment.centerLeft,
                          color: Colors.blueGrey,
                          
                          width: 400,
                          margin: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("@${reqList.elementAt(index)}"),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(icon:Icon(Icons.clear),onPressed: (){
                                    //reddet
                                    //sayfa yenileme
                                    RestartWidget.restartApp(context);
                                    
                                    
                                  },),
                                  SizedBox(width: 16),
                                  IconButton(icon:Icon(Icons.check),onPressed: (){
                                    DataBaseConnection.addFriend(userName, reqList.elementAt(index));
                                    //kabul et
                                    //sayfa yenileme
                                    RestartWidget.restartApp(context);
                                  },)
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
