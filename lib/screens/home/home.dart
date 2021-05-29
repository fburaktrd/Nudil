import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_app/models/tarihkart.dart';
import 'package:flutter_first_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.red[50],
        
        
        body: TarihKart(),
        
        
        
        );
        
  }
}
