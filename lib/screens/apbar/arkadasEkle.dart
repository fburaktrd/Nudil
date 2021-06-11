import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/apbar/arkadasArama.dart';
import 'package:flutter_first_app/screens/apbar/arkadasIstekleri.dart';
import 'package:flutter_first_app/screens/apbar/arkadaslarim.dart';
import 'package:flutter_first_app/services/auth.dart';
import './apbar.dart';



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

            setBilgiler();
            setState(() {
              
            });
          }
          
          return true;
        },
        child: FutureBuilder(
          future: setBilgiler(),
          builder:(context,snapShot) {
            print(snapShot.connectionState);
            if(snapShot.connectionState==ConnectionState.waiting){
              
              return Center(child: CircularProgressIndicator(strokeWidth: 2,backgroundColor: Colors.amber,));
            }
            else{return PageView(
            controller: kontrol,
            children: [
              //Arkadaş arama
              ArkadasArama(kontrol: kontrol,userName: userName,),
              //Arkadaş istkleri
              ArkadasIstekleri(kontrol: kontrol,reqLength: reqLength,reqList: reqList,userName: userName,),
              //Arkadaşlarım 
              Arkadaslarim(kontrol: kontrol,friLength: friLength,friList: friList,),
              
            ],
          );}
          },
        ),
      ),
      
    );
  }
}
