import 'package:flutter/material.dart';

class TarihSecim extends StatefulWidget{
  final String gid;//grup id
  final List<DateTime> tarihler;
  
  TarihSecim({
    this.gid,
    this.tarihler
  });
  @override
  _TarihSecimState createState() =>_TarihSecimState();
  
  
}

class _TarihSecimState extends State<TarihSecim>{
  

  
  
  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(.45,-1),
            child: Container(
              width: MediaQuery.of(context).size.width/1.32,
              child: SingleChildScrollView(
                
                scrollDirection: Axis.horizontal,
                child: Container(
                  
                  height: 200,
                  
                  alignment: Alignment.center,
                
                  
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index1) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(10, (index2){
                            return  Container(
                              alignment: Alignment.center,
                              color: Colors.yellow,
                              margin: EdgeInsets.all(5),
                              width: 100,
                              height: 80,
                              child: GestureDetector(
                                
                                //child: Text("$index2+$index1"),
                                onTap: (){print("$index1 + $index2");Navigator.of(context).pop();},
                              ),
                            
                            );
                          } ),
                        );
                      }),
                    ),
                  ),
              ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-1,-.98),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                    color: Colors.blue
                  ),
                  width: 100,
                  height: 85,
                  child: Text("Katılanlar",style: TextStyle(fontSize: 12)),
                  margin: EdgeInsets.all(4),
                ),
                Container(
                  width: 100,
                  height: 85,
                  child: Text("Ben",style: TextStyle(fontSize: 12),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                    color: Colors.cyan
                  ),
                  margin: EdgeInsets.all(4),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}