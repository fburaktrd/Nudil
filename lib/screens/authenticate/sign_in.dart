import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_app/screens/authenticate/register.dart';
import 'package:flutter_first_app/screens/authenticate/reset_page.dart';
import 'package:flutter_first_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String pass = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/homescreen.jpg"),
                      colorFilter:
                          ColorFilter.mode(Colors.white12, BlendMode.darken),
                      fit: BoxFit.cover),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Align(
                alignment: Alignment(0, .0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          //backgroundBlendMode: BlendMode.darken,
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Text(
                          "  Nud??l  ",
                          style: TextStyle(
                            //fontStyle: FontStyle.,
                            fontSize: 32,

                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black38,
                            backgroundBlendMode: BlendMode.darken),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email Giriniz",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.mail_rounded,
                                size: 35,
                                color: Colors.white.withAlpha(225),
                              ),
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 13),
                            keyboardType: TextInputType.text,
                            validator: (val) =>
                                val.isEmpty ? 'Email Giriniz' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                      ),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black38,
                            backgroundBlendMode: BlendMode.dstOut),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "??ifre Giriniz", // buras?? de??i??tirilir keyfi konulur bir ??eyler.
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.vpn_key_rounded,
                                size: 35,
                                color: Colors.white.withAlpha(225),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            obscuringCharacter: '*',
                            validator: (val) => val.length < 6
                                ? '6 karakterden fazla uzunlukta ??ifre giriniz'
                                : null,
                            onChanged: (val) {
                              setState(() => pass = val);
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            splashColor: Colors.blueGrey,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Register();
                              }));
                            },
                            child: Text('Kay??t Ol',
                                style: TextStyle(
                                    color: Color(0xff30374b),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          RawMaterialButton(
                            child: Text('Giri?? Yap',
                                style: TextStyle(
                                    color: Color(0xff30374b),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            //fillColor: Colors.blue.withAlpha(0),
                            //constraints: BoxConstraints(minWidth: 100),
                            //splashColor: Colors.deepOrange,
                            animationDuration: Duration(seconds: 5),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result = await _auth
                                    .signInWithEmailAndPassword(email, pass);

                                if (result == null) {
                                  setState(
                                    () => error =
                                        'Girilen de??erlere g??re giri?? yap??lamad??.',
                                  );
                                  final snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        error,
                                        style: TextStyle(fontSize: 20),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                      backgroundColor: Colors.lightBlue,
                                      content: Text(
                                        "Ba??ar??yla giri?? yap??ld?? !",
                                        style: TextStyle(fontSize: 20),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                    right: Radius.circular(20))),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ResetPass())),
                              child: Text(
                                '??ifremi unuttum',
                                style: TextStyle(
                                    color: Color(0xff30374b),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
