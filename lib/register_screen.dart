import 'package:agri_doc/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Color buttonColor = Color(0xff519657);
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _auth = FirebaseAuth.instance;

  Color bgColor = Color(0xff4caf50);
  Color fieldColor = Color(0xff80e27e);

  Color boxColor = Color(0xffE4E3E3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.maxFinite,
              height: 360.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 10.0,),

                            TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  prefixIcon: Icon(Icons.accessibility),
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              obscureText: true,
                              controller: _password,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  prefixIcon: Icon(Icons.accessibility),
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        String email = _email.text;
                        String pass = _password.text;

                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                          if(newUser!=null) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(HomeScreen.id, (Route<dynamic> route) => false);
                          }
                        } catch(e) {
                          print(e);
                        }

                      },
                      child: SizedBox(
                          width: double.maxFinite,
                          height: 50.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.brown,
                            ),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}