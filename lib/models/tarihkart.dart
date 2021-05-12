import 'package:flutter/material.dart';
import './grup.dart';

class TarihKart extends StatefulWidget{
  
  @override
  _TarihKartState createState() => _TarihKartState();
  
}
  
class _TarihKartState extends State<TarihKart>{
  
  int sayi=40;
  List<Widget> olustur=[];
  @override
  void initState() {
    
    olustur=listeYapici(sayi,context);
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      
      body: Container(
          decoration: BoxDecoration(

            ),
          child: GridView.count(
            
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            childAspectRatio:.75,
            children: olustur,
            
            
            
            ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "asd"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "asd"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "asd")
        ],),
    );
      
    
    
    
    
  }
  
} 
    
List<Widget> listeYapici(int sayi,BuildContext context){
  bool tek=false;
  List<Widget> liste=[];
  //faik event sayisi
  for(int i=0;i<sayi;i++){
    
    String x=i.toString();
    Widget a=GestureDetector(
      onTap: (){
        tek= !tek;
        
      },
      onDoubleTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return Grup(i: x);
            },
          
          )//        Grup(i: x),
          
        );
      },
      child: Container(
        
        alignment: Alignment.center,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white70
        ),
        child: Container(child: Text("title $i",style: TextStyle(fontSize: 30,color: Colors.black),)),
      ),
    );
    liste.add(a);
  }
  
  return liste;
}


