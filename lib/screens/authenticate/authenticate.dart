import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_first_app/screens/authenticate/register.dart';
import 'package:flutter_first_app/screens/authenticate/sign_in.dart';
>>>>>>> parent of 86051c9 (Revert "User sign up and in added")

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('authenticate'),
    );
  }
}
=======
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
}
>>>>>>> parent of 86051c9 (Revert "User sign up and in added")
