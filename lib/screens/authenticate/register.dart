import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/screens/authenticate/sign_in.dart';
import 'package:flutter_first_app/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String displayName = '';
  String password = '';
  String error = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        title: Text('Sign up to our_app_name'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.remove),
              label: Text('Sign In'),
              onPressed: () {
                //widget.toggleView();
                return SignIn();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Enter the password 6+ chars long'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Kullanıcı Adınızı Giriniz' : null,
                onChanged: (val) {
                  setState(() => displayName = val);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(displayName); //denemek için yazdırdım
                  DataSnapshot userNameDbResult =
                      await DataBaseConnection.getUserName(displayName);
                  print(userNameDbResult.value);
                  if (userNameDbResult.value == null) {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.realRegister(
                          email, password, displayName);
                      print("Kaydedildi.");
                      if (result == null) {
                        setState(() => error = 'Please supply a valid email.');
                      }
                    }
                  } else {
                    setState(() => error = 'This username already taken.');
                    print("Kaydedilmedi");
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
