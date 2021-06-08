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
  int friLength=0;
  List<String> friList = [];
  String userName="";
  final AuthService _auth = AuthService();
  Future<void> setBilgiler()async{
    String uid =await _auth.getUseruid();
    print(uid);
    userName=await DataBaseConnection.getUserDisplayName(uid);

    reqList=await DataBaseConnection.returnRequests(userName);
    if(reqList!=null){
      reqLength=reqList.length;
    }
    friList=await DataBaseConnection.returnFriends(userName);
    if(friList!=null){
      friLength=friList.length;
    }

    print(reqList);
    if(this.mounted){
      setState(() {
        
      });
    }
    
  }



  PageController kontrol=new PageController(initialPage: 1,viewportFraction: .99);
  String aranacakKisi = "";
  @override
  void initState(){
    setBilgiler();
    super.initState();
    
  }
  
 
  
  @override
  Widget build(BuildContext context) {
    
    print(reqList);
    
    return Scaffold(
      appBar: Apbar(context: context,widget: widget).x(),
      
      body: NotificationListener<OverscrollNotification>(
        onNotification: (notific){

          print(notific.overscroll);
          if(notific.overscroll<0){
            
            //sayfa yenileme
            
            //RestartWidget.restartApp(context);
            setBilgiler();
            
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
                            bool b =await  DataBaseConnection.getFriend(userName, aranacakKisi);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        RawMaterialButton(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Arkadaşlarım"),
                                Icon(Icons.chevron_right_sharp)
                              ],
                            ),
                          ),
                          onPressed: (){
                            kontrol.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                          }
                        )
                      ],
                    ),
                    
                    Column(
                      children:reqLength==0?[Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.all(7),
                        decoration: ShapeDecoration(color:Color(0xff30374b).withAlpha(240),
                          shape:BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
                        ),
                        
                        child: Text("Arkadaşlık isteği yok.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                      )]:[Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.all(7),
                        decoration: ShapeDecoration(color:Color(0xff30374b).withAlpha(240),
                            shape:BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
                        ),

                        child: Text("Arkadaşlık istekleri.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                      )]+

                      List.generate(reqLength, (index){
                        return Container(
                          padding: EdgeInsets.fromLTRB(8,20,16,20),
                          alignment: Alignment.centerLeft,


                          width: 400,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(color:Color(0xff30374b).withAlpha(240),
                            borderRadius:BorderRadius.circular(14)

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("@${reqList.elementAt(index)}",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize:17),),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(icon:Icon(Icons.clear,color: Colors.white,),onPressed: (){
                                    //reddet
                                    //sayfa yenileme
                                    RestartWidget.restartApp(context);
                                    
                                    
                                  },),
                                  SizedBox(width: 16),
                                  IconButton(icon:Icon(Icons.check,color: Colors.white,),onPressed: (){
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
            //Arkadaşlarım 
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
                            Text("Arkadaş İstekleri")
                          ],
                        ),
                      ),
                      onPressed: (){
                        kontrol.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                      }
                    ),
                    
                    Column(
                      children:friLength==0?[Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.all(7),
                        decoration: ShapeDecoration(color:Color(0xff30374b).withAlpha(240),
                            shape:BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
                        ),

                        child: Text("Arkadaşlık isteği yok.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                      )]:[Container(
                        padding: EdgeInsets.all(9),
                        margin: EdgeInsets.all(7),
                        decoration: ShapeDecoration(color:Color(0xff30374b).withAlpha(240),
                            shape:BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
                        ),

                        child: Text("Arkadaşlarım",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                      )]+ List.generate(friLength, (index){
                        return Container(
                          padding: EdgeInsets.fromLTRB(8,24,16,20),
                          alignment: Alignment.centerLeft,
                          decoration: ShapeDecoration(color:Color(0xff30374b).withAlpha(240),
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                          ),
                          width: 400,
                          margin: EdgeInsets.all(8),
                          child: Text("@${friList.elementAt(index)}",style: TextStyle(color: Colors.white,fontSize:14,fontWeight:FontWeight.bold),),
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
