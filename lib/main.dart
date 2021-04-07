import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/screens/wrapper.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
   
        primarySwatch: Colors.blue,

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

      ),
    );
  }


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> eventler=["18 Ekim","17 Kasim","12 ocak","14 Subat","8 Temmuz"];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: 
          Stack(
              children: [

                Image(image: NetworkImage("https://miro.medium.com/max/1838/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"),
                fit: BoxFit.contain,),
                Center(heightFactor: 1.2,
                child: Container(
                height: 450,
                alignment: Alignment.center,
                child: Swiper(
                
                  viewportFraction: .8,
                  scale: .8,
                
                  itemCount: eventler.length,
                  itemBuilder: (context,index){
                    return Container(
                      
                          decoration: BoxDecoration(
                              gradient:LinearGradient(
                              colors:[Colors.deepOrange[700],Colors.cyan[200]],
                              begin: Alignment.lerp(Alignment.centerLeft, Alignment.topRight, .33),
                              end: Alignment.bottomRight,
                              stops: [.0,1],
                             
                              
                              ), 
                              borderRadius: BorderRadius.circular(15)
                            ),
                          alignment: Alignment.topCenter,
                          width: 300,
                          height: 450,
                          child: Text("${eventler[index]}"),
                          
                      
                    );
                  },
                  
                ),
              ),
            ),
            
              ]),
              
      backgroundColor: Colors.black,
      ); 
    
  }
}



