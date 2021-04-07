import 'package:flutter/material.dart';

import 'package:flutter_first_app/screens/authenticate/register.dart';
import 'package:flutter_first_app/screens/authenticate/sign_in.dart';

import 'package:flutter_first_app/screens/authenticate/register.dart';
import 'package:flutter_first_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('authenticate'),
    );
  }
}

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }


