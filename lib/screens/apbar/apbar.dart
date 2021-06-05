import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/services/auth.dart';

import 'arkadasEkle.dart';

final AuthService _auth = AuthService();
class Apbar {
  final BuildContext context;
  final Widget widget;
  Apbar({this.context,this.widget});



  AppBar x(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Nudıl"),
      actions:[ 
        IconButton(
          
          icon: Icon(Icons.person_add_alt_1),
          onPressed: () {
            widget.key.toString()=="[<'asd'>]"?Navigator.pop(context):Navigator.push(context, MaterialPageRoute(builder: (context)=>RestartWidget(child: ArkadasEkle())));
            
          }
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async{
            await _auth.signOut();
            
          }
        ),
      ]
    );

  }
  
}