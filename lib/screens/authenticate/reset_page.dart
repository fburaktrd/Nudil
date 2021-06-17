import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/database.dart';
import 'package:flutter_first_app/services/auth.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPage createState() => _ResetPage();
}

class _ResetPage extends State<ResetPass> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff30374b),
          elevation: 0.0,
          title: Text('Şifre Yenile'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                RawMaterialButton(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff30374b),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Parola sıfırla',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () async {
                      var emails = await DataBaseConnection.getEmails();
                      if (!(emails.contains(email))) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height / 3,
                                    horizontal: 40),
                                title: Text("Uyarı"),
                                content:
                                    Text("$email ile ilişkili bir hesap yok."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text("Tamam")),
                                ],
                              );
                            });
                      } else {
                        _auth.sendResetReqPassword(email);
                        final snackBar = SnackBar(
                            backgroundColor: Colors.lightBlue,
                            content:
                                Text("Parola sıfırlama emaili gönderildi!"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
