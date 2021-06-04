import 'package:flutter/material.dart';
import './apbar.dart';


class ArkadasEkle extends StatefulWidget {
  Key key=new Key("asd");
 
  @override
  Ekle createState() => Ekle();
}

class Ekle extends State<ArkadasEkle> {
  
  PageController kontrol=new PageController(initialPage: 1,viewportFraction: .99);
  String aranacakKisi = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apbar(context: context,widget: widget).x(),
      
      body: PageView(
        controller: kontrol,
        children: [
          //Arkadaş arama
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RawMaterialButton(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Arkadaş İstekleri"),
                        Icon(Icons.chevron_right_sharp)
                      ],
                    ),
                  ),
                  onPressed: (){
                    kontrol.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                  }
                ),
                
                Container(
                  margin: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.withAlpha(200)),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    margin: EdgeInsets.all(12),
                    child: TextField(
                      
                      decoration: InputDecoration(
                       
                        hintText: "ara",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      toolbarOptions:
                          ToolbarOptions(selectAll: true, copy: true, paste: true),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      onSubmitted: (arama) {
                        //aranacak kişi buradan
                        aranacakKisi = arama;

                        setState(() {});
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(14),
                  padding: EdgeInsets.all(15),
                  child: Text(aranacakKisi.length == 0 ? "" : "@" + aranacakKisi),
                ),
                
              ],
            ),
          ),
          //Arkadaş istkleri
          Container(
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
                          Text("Arkadaş ara")
                        ],
                      ),
                    ),
                    onPressed: (){
                      kontrol.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                    }
                  ),
                  
                  Column(
                    children: List.generate(40, (index){
                      return Container(
                        padding: EdgeInsets.fromLTRB(8,24,16,20),
                        alignment: Alignment.centerLeft,
                        color: Colors.blueGrey,
                        
                        width: 400,
                        margin: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("@${String.fromCharCode(((index*23)%25)+65)}${String.fromCharCode(((index*13)%25)+65)}${String.fromCharCode(((index*7)%25)+65)}"),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(icon:Icon(Icons.clear),onPressed: (){
                                  print(index);
                                  Navigator.pop(context);
                                  
                                },),
                                SizedBox(width: 16),
                                Icon(Icons.check)
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
          ),
        ],
      ),
      
    );
  }
}

/* static dialogArk(BuildContext context){
    
    
    showDialog( context: context,builder: (context){
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("ark istekleri"),
              Container(color: Colors.black,width: 10,height: 10,),
              Text("ark istek gonder")
            ],

          ),
          insetPadding: EdgeInsets.all(100),
          contentPadding: EdgeInsets.all(8),
          children: List.generate(40, (index){
            return Container(
              padding: EdgeInsets.fromLTRB(8,24,16,20),
              alignment: Alignment.centerLeft,
              color: Colors.blueGrey,
              
              width: 400,
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("@${String.fromCharCode(((index*23)%25)+65)}${String.fromCharCode(((index*13)%25)+65)}${String.fromCharCode(((index*7)%25)+65)}"),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon:Icon(Icons.clear),onPressed: (){
                        print(index);
                        Navigator.pop(context);
                        
                      },),
                      SizedBox(width: 16),
                      Icon(Icons.check)
                    ],
                  )
                ],
              ),
            );
          } )
        );
      }, 
    );
  } */
  /* Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withAlpha(200)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 200),
                margin: EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  toolbarOptions:
                      ToolbarOptions(selectAll: true, copy: true, paste: true),
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  onSubmitted: (arama) {
                    aranacakKisi = arama;

                    setState(() {});
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(14),
              padding: EdgeInsets.all(15),
              child: Text(aranacakKisi.length == 0 ? "" : "@" + aranacakKisi),
            )
          ],
        ),
      ), */