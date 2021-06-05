import 'package:flutter/material.dart';

class ListeButon extends StatefulWidget{
  
  final String isim;
  bool seci=false;
  
  ListeButon({this.isim});
 
  @override
  ListeButonu createState()=>ListeButonu();

}
class ListeButonu extends State<ListeButon> {
  
  void asdf(){
    widget.seci=!widget.seci;
    setState(() {
      
    });
    
  }
  
  @override
  Widget build(BuildContext context){
    
    return GestureDetector(
      onTap: (){
        asdf();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        margin: widget.seci?EdgeInsets.all(12):EdgeInsets.all(4),
        
        decoration: BoxDecoration(
          color: widget.seci?Colors.blueGrey.withBlue(120):Colors.blueGrey,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            CircleAvatar(
              backgroundColor: Colors.greenAccent.withAlpha(125),
              maxRadius: widget.seci?24:32,
              
            ),
            Text("${widget.isim} - ${widget.seci}")
          ],
        ),
      ),
    );
  }
}