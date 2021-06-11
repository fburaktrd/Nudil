import 'package:flutter/material.dart';

class Arkadaslarim extends StatelessWidget{
  final PageController kontrol;
  final int friLength;
  final List<String> friList;
  Arkadaslarim({this.kontrol,this.friLength,this.friList});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}