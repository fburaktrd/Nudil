import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/screens/wrapper.dart';
import 'package:flutter_first_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

