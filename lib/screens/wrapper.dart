import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_first_app/screens/home/home.dart';
=======
import 'package:flutter_first_app/models/user.dart';
import 'package:flutter_first_app/screens/authenticate/authenticate.dart';
import 'package:flutter_first_app/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_first_app/models/user.dart';
>>>>>>> parent of 86051c9 (Revert "User sign up and in added")

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Giriş yapılma durumuna göre ya Home ya da Authenticate widget return edecek
    return Home();
=======
    final user = Provider.of<User>(context);
    print(user);
    // Giriş yapılma durumuna göre ya Home ya da Authenticate widget return edecek
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
>>>>>>> parent of 86051c9 (Revert "User sign up and in added")
  }
}
