import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './tarihler.dart';

class Grup extends StatelessWidget{
  final String i;

  Grup({this.i});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }
  @override
  Widget build(BuildContext context){
    //double height=MediaQuery.of(context).size.height;
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.person_pin_rounded), onPressed: _openEndDrawer)
        ],
        leading: BackButton(onPressed: (){Navigator.pop(context);},),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
        title: Container(
          child: Text(
            "title $i"
            ),
        ),
      ),
      endDrawer: SafeArea(
        child: Drawer()
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16)
                ),
                margin: EdgeInsets.all(32),
                child:GestureDetector(
                  onTapUp: (tapUpDetails){Navigator.push(context, MaterialPageRoute(builder: (context)=>TarihSecim()));},
                  child: Container(
                    child: Text("Tarihler"),
                    padding: EdgeInsets.fromLTRB(28, 20, 28, 20),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 224
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "   dasdasdadsfdfffffffffffasssssssssfsafsdfadfasfsdfasdasdasdadsfdfffffffffffasssssssssfsafsdfadfasfsdfasdasdasdadsfdfffffffffffasssssssssfsafsdfadfasfsdfas"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}