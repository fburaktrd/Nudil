import 'package:flutter/material.dart';

import 'package:flutter_first_app/models/tarihkart.dart';


class Home extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.red[50],
        
        
        body: TarihKart(),
        
        
        
        );
        
  }
}
