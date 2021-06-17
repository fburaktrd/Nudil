import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff30374b),
        elevation: 0.0,
        centerTitle: true,
        title: Text('Kayıt Ol'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        size: 27,
                        color: Color(0xff30374b),
                      ),
                      hintText: "Email Giriniz",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              /*SizedBox(
                height: 20.0,
              ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Enter the password 6+ chars long'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key_rounded,
                        size: 27,
                        color: Color(0xff30374b),
                      ),
                      hintText: "Şifre Giriniz ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                child: TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Kullanıcı Adınızı Giriniz' : null,
                  onChanged: (val) {
                    setState(() => displayName = val);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.drive_file_rename_outline,
                        size: 27,
                        color: Color(0xff30374b),
                      ),
                      hintText: "Kullanıcı Adınızı Giriniz",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),

              RaisedButton(
                color: Color(0xff30374b),
                child: Text(
                  'Kaydet',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(displayName); //denemek için yazdırdım
                  DataSnapshot userNameDbResult =
                      await DataBaseConnection.getUserName(displayName);
                  print(userNameDbResult.value is Future);
                  if (userNameDbResult.value == null) {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.realRegister(
                          email, password, displayName);
                      print("Kaydedildi.");
                      if (result == null) {
                        setState(() => error = 'Please supply a valid email.');
                        final snackBar = SnackBar(
                            backgroundColor: Colors.lightBlue,
                            content: Text(
                              "Başarıyla kayıt olundu !",
                              style: TextStyle(fontSize: 20),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
