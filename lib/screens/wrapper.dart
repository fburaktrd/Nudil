import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Giriş yapılma durumuna göre ya Home ya da Authenticate widget return edecek
    return Home();
  }
}
