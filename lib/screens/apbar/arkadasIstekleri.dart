import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/models/database.dart';

class ArkadasIstekleri extends StatelessWidget{

  final PageController kontrol;
  final int reqLength;
  final List<String> reqList;
  final String userName;
  ArkadasIstekleri({this.kontrol,this.reqLength,this.reqList,this.userName});
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
    
  }
}