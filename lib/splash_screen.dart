import 'dart:async';

import 'package:agri_doc/home_screen.dart';
import 'package:agri_doc/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RegisterScreen.id, (Route<dynamic> route) => false); //It will redirect  after 3 seconds
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 140.0,
                height: 140.0,
                child: Image.asset("assets/swallow.png"),
              ),
              Text(
                'NeelaKuruvi',
                style: TextStyle(
                  fontSize: 35.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
