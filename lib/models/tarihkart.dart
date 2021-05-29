import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/authenticate/sign_in.dart';
import 'package:flutter_first_app/screens/eventOlusturma/calendar/planlama.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';


class TarihKart extends StatefulWidget{

  @override
  _TarihKartState createState() => _TarihKartState();
  
}
  
class _TarihKartState extends State<TarihKart>{
  final AuthService _auth = AuthService();
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
        appBar: AppBar(
          title: Text('our_app_name'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
      
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
        floatingActionButton: RawMaterialButton(
        child: Container(
    decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.all(8),
    child: Text('Planlama',
    style: GoogleFonts.montserrat(
    color: Color.fromRGBO(59, 57, 60, 1),
    fontSize: 22,
    fontWeight: FontWeight.bold)),
    ),
    onPressed: () => Navigator.push(
    context, MaterialPageRoute(builder: (context) => BilgiAlma())),
    ));
      
    
    
    
    
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


